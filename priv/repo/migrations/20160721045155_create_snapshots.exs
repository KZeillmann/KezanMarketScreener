defmodule KezanMarketScreener.Repo.Migrations.CreateSnapshots do
  use Ecto.Migration

  def change do
    create table(:snapshots) do
      add :realm, :string
      add :url, :string
      add :last_modified, :datetime
    end
  end
end
