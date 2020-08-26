INSERT INTO maxdac_blog.sections (id, title, content, article_id, inserted_at, updated_at, `order`) VALUES (1, 'Introduction', '<p>Everyone knows the importance and the comfort that the pipe operator in Elixir is able to provide.</p><p>It allows, in particular, to reuse the result of the last function as the first parameter of the subsequent function. Something like this:</p><pre class="ql-syntax ql-align-center" spellcheck="false">parameter |&gt; first_function() |&gt; second_function()
</pre><p>In this example, the variable <em>parameter</em> is passed as the first parameter of the function <em>first_function</em>. Then, the result of this call is passed to the <em>second_function</em>, that returns the result.</p><p>This operator allows a function to be represented more elegantly. Let''s imagine, for instance, that a function must perform these operations:</p><pre class="ql-syntax" spellcheck="false">def perform_something(params) do
    params = first_function(params)
    params = second_function(params)
    third_function(params)
end
</pre><p>With the help of the <strong>pipe</strong> operator, it is possible to rewrite the function in the following way:</p><pre class="ql-syntax" spellcheck="false">def perform_something(params) do
    params
    |&gt; first_function()
    |&gt; second_function()
    |&gt; third_function()
end
</pre><p>This is less clumsy and more straightforward, more so if the functions accept other parameters. It gives a sense of flow, that helps reading the code.</p><p>It''s a shame that, by its definition, this operator does not manage the frequent error type in Elixir / Erlang:</p><pre class="ql-syntax ql-align-center" spellcheck="false">{:ok, result} | {:error, reason}
</pre><p>In other words, if a function returns this type, and the next function only accept the result type, it is not possible to use the pipe operator.</p><p>In the following sections of this article, I will propose a different implementation of this operator, that can manage subsequent calls to functions that returns this "monad".</p>', 1, '2020-08-24 23:18:58', '2020-08-25 20:38:59', null);
INSERT INTO maxdac_blog.sections (id, title, content, article_id, inserted_at, updated_at, `order`) VALUES (2, 'The macro behind the operator', '<p>The pipe operator is a macro in Elixir. From the Elixir source code available on GitHub (<a href="https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/kernel.ex" rel="noopener noreferrer" target="_blank">https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/kernel.ex</a>):</p><pre class="ql-syntax" spellcheck="false">defmacro left |&gt; right do
  [{h, _} | t] = Macro.unpipe({:|&gt;, [], [left, right]})

  fun = fn {x, pos}, acc -&gt;
    Macro.pipe(acc, x, pos)
  end
	
  :lists.foldl(fun, h, t)
end
</pre><p>This implementation is part of the Kernel module in Elixir. In order to override this behaviour, it will be necessary to implement another macro that could take care of the incremental cases.</p><p>The first case that I would like to address is the following. Let''s suppose that an implementation must call a function that returns an <strong>{:ok, result</strong>} type, and then, with the <strong>result</strong>, the function will have to call a second function that returns a normal value:</p><pre class="ql-syntax" spellcheck="false">def first_function(%{"id" =&gt; id"}), do: {:ok, id}
def first_function(_), do: {:error, :not_found}

def second_function(id) do
  perform_query!(id)
end

def function(params) do
  {:ok, id} = first_function(params)
  second_function(id)
end
</pre><p>As mentioned before, it is not possible to concatenate the two function calls with the pipe, because the result of the first function is incompatible with the first parameter type of the second function. In this case, the behaviour of the "enhanced" pipe would be to take the <strong>id</strong> parameter from the first result, and pass it to the second function, or return the error result if this is the result of the first call. Note that, in order to maintain coherence with the return type, if the two call succeed, the return type would be <strong>{:ok, result}</strong>.</p><p>The second behaviour is basically the base behaviour, applied to the "monad" return type, in that if a function returns the error or ok type, and the following function accept this same type, the macro should behave normally, injecting the result as the first parameter of the second function. This would have to be the case in the base behaviour, if neither the result of the first function nor the first parameter of the second function are of ok / result type.</p><p>In other words, other than keeping the default behaviour, we would like to "parse" the ok / error return type, extracting the result or halting the execution.</p>', 1, '2020-08-25 15:53:14', '2020-08-25 21:03:36', null);