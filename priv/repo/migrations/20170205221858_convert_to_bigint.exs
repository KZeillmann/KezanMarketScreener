defmodule KezanMarketScreener.Repo.Migrations.ConvertToBigint do
  use Ecto.Migration

  def change do
    alter table(:auctions) do
      modify :bid, :bigint
      modify :buyout, :bigint
    end
  end
end
