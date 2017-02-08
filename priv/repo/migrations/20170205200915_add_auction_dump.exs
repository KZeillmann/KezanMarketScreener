defmodule KezanMarketScreener.Repo.Migrations.AddAuctionDump do
  use Ecto.Migration

  def change do
    create table(:auction_dumps) do
      add :timestamp, :utc_datetime
      add :server, :string
      add :url, :string
      timestamps()
    end

    alter table(:auctions) do
      add :auction_dump_id, references(:auction_dumps)
    end
  end
end
