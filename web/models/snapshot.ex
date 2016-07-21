defmodule KezanMarketScreener.Snapshot do
  use KezanMarketScreener.Web, :model
  
  schema "snapshots" do
    field :realm, :string
    field :url, :string
    field :last_modified, Ecto.DateTime
  end
end
