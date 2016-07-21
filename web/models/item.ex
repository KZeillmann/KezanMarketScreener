defmodule KezanMarketScreener.Item do
  use KezanMarketScreener.Web, :model

  schema "items" do
    field :name, :string
    field :description, :string
    field :icon, :string
    field :buy_price, :integer
    field :sell_price, :integer
    field :is_auctionable, :boolean
  end
end
