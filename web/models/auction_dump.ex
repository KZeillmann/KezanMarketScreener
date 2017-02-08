defmodule KezanMarketScreener.AuctionDump do
    use KezanMarketScreener.Web, :model
    schema "auction_dumps" do
      field :timestamp, :utc_datetime
      field :server
      field :url
      has_many :auctions, KezanMarketScreener.Auction
      timestamps()
    end
end
