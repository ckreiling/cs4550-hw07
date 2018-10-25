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

  pipeline :authenticate do
    plug TodoAppWeb.Plugs.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", SessionController, :login
    post "/login", SessionController, :create
    get "/register", UserController, :new
    post "/register", UserController, :create
  end

  scope "/app", TodoAppWeb do
    pipe_through [:browser, :authenticate]

    get "/me", UserController, :me
    get "/my-todos", TodoItemController, :my_todos
    get "/underlings", TodoItemController, :show_underlings_todos
    get "/logout", SessionController, :delete
    resources "/managed", ManagerController, only: [:index, :new, :edit, :delete, :create]
    resources "/todo-items", TodoItemController, only: [:edit, :new]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoAppWeb do
  #   pipe_through :api
  # end
end
