defmodule MaxdacBlog.ArticlesTest do
  use MaxdacBlog.DataCase

  alias MaxdacBlog.Articles
  alias MaxdacBlog.Articles.Article

  describe "articles" do

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert %{Articles.get_article!(article.id) | sections: nil} == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Articles.create_article(@valid_attrs)
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Articles.update_article(article, @update_attrs)
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == %{Articles.get_article!(article.id) | sections: nil}
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end

  describe "sections" do
    alias MaxdacBlog.Articles.Section

    @article_attrs %{title: "some title"}

    @valid_attrs %{content: "some content", title: "some title", order: 2}
    @update_attrs %{content: "some updated content", title: "some updated title", order: 3}
    @invalid_attrs %{content: nil, title: nil, order: nil}

    def section_fixture(attrs \\ %{}) do
      {:ok, article} =
        Articles.create_article(@article_attrs)

      {:ok, section} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.put(:article_id, article.id)
        |> Articles.create_section()

      {section, article}
    end

    test "list_sections/0 returns all sections" do
      {section, _} = section_fixture()
      assert Articles.list_sections() == [section]
    end

    test "get_section!/1 returns the section with given id" do
      {section, _} = section_fixture()
      assert Articles.get_section!(section.id) == section
    end

    test "create_section/1 with valid data creates a section" do
      {:ok, article} = Articles.create_article(@article_attrs)
      assert {:ok, %Section{} = section} =
        Articles.create_section(@valid_attrs |> Map.put(:article_id, article.id))
      assert section.content == "some content"
      assert section.title == "some title"
    end

    test "create_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_section(@invalid_attrs)
    end

    test "update_section/2 with valid data updates the section" do
      {section, _} = section_fixture()
      assert {:ok, %Section{} = section} = Articles.update_section(section, @update_attrs)
      assert section.content == "some updated content"
      assert section.title == "some updated title"
    end

    test "update_section/2 with invalid data returns error changeset" do
      {section, _} = section_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_section(section, @invalid_attrs)
      assert section == Articles.get_section!(section.id)
    end

    test "delete_section/1 deletes the section" do
      {section, _} = section_fixture()
      assert {:ok, %Section{}} = Articles.delete_section(section)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_section!(section.id) end
    end

    test "change_section/1 returns a section changeset" do
      {section, _} = section_fixture()
      assert %Ecto.Changeset{} = Articles.change_section(section)
    end

    test "list_article_sections/1 returns all sections for the created article" do
      {section, article} = section_fixture()
      assert Articles.list_article_sections(article.id) == [section]
    end

    test "list_article_sections/1 does not return other articles' sections" do
      {:ok, previous_article} =
        Articles.create_article(%{"title" => "Other title"})

      {section, article} = section_fixture()
        assert Articles.list_article_sections(previous_article.id) == []
    end

    test "get_article!/1 returns a list of sections" do
      {section, %Article{id: article_id}} = section_fixture()
      article = Articles.get_article!(article_id)
      assert article.sections == [section]
    end
  end
end
