defmodule KezanMarketScreener.Auction do
  use KezanMarketScreener.Web, :model

  schema "auctions" do
    field :item, :integer
    field :owner, :string
    field :owner_realm, :string
    field :bid, :integer
    field :buyout, :integer
    field :quantity, :integer
    field :time_left, :string
  end
end
