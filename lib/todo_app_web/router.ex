defmodule TodoAppWeb.Router do
  use TodoAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TodoAppWeb.Plugs.FetchUserFromSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", SessionController, :login
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    get "/register", UserController, :new
    get "/me", UserController, :show
    resources "/users", UserController
    resources "/managed", ManagerController
    resources "/todo-items", TodoItemController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoAppWeb do
  #   pipe_through :api
  # end
end
