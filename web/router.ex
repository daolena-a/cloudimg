defmodule Cloudimg.Router do
  use Cloudimg.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Cloudimg do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/image", PageController, :image
  end

  # Other scopes may use custom stacks.
  # scope "/api", Cloudimg do
  #   pipe_through :api
  # end
end
