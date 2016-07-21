defmodule KezanMarketScreener.PageController do
  use KezanMarketScreener.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
