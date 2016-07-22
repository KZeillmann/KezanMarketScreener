defmodule KezanMarketScreener.ItemController do
  use KezanMarketScreener.Web, :controller

  def show(conn, %{ "id" => id }) do
    item = Repo.get(KezanMarketScreener.Item, id)
    render conn, "show.html", item: item
  end
end
