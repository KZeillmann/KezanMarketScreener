defmodule KezanMarketScreener.ItemView do
  use KezanMarketScreener.Web, :view
  alias KezanMarketScreener.Item

  def buy_price( %Item{buy_price: buy_price} ) do
    format_price(buy_price)
  end

  def sell_price( %Item{sell_price: sell_price}) do
    format_price(sell_price)
  end

  def icon(%Item{ icon: icon }) do
    "http://us.media.blizzard.com/wow/icons/56/" <> icon <> ".jpg"
  end

  def format_price(price) do
    price/10000
    |> Float.round(2)
    |> to_string
    |> Kernel.<>("g")
  end
end
