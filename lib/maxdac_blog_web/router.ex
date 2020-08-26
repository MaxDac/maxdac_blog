defmodule MaxdacBlogWeb.Router do
  use MaxdacBlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MaxdacBlogWeb.AuthPlug
  end

  pipeline :admin_browser do
    plug :browser
    plug MaxdacBlogWeb.AdminPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MaxdacBlogWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/articles", ArticleController, only: [:index, :show]
    get "/biography", PageController, :biography
    get "/portfolio", PageController, :portfolio
  end

  scope "/admin", MaxdacBlogWeb do
    pipe_through :admin_browser

    get "/", AdminController, :index
    get "/articles/:id", AdminController, :edit_article
    get "/article/:article_id/sections/new", AdminController, :new_section
    get "/article/sections/:id/edit", AdminController, :edit_section
    post "/article/:article_id/sections", AdminController, :create_section
    put "/article/sections/:id", AdminController, :update_section
  end

  # Other scopes may use custom stacks.
  # scope "/api", MaxdacBlogWeb do
  #   pipe_through :api
  # end
end
