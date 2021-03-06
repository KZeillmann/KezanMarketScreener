defmodule KezanMarketScreener.Router do
  use KezanMarketScreener.Web, :router

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

  scope "/", KezanMarketScreener do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/items", ItemController, only: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", KezanMarketScreener do
  #   pipe_through :api
  # end
end
