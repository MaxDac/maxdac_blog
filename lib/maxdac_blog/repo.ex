defmodule MaxdacBlog.Repo do
  use Ecto.Repo,
    otp_app: :maxdac_blog,
    adapter: Ecto.Adapters.MyXQL
end
