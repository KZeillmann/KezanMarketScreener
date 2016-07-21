# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     KezanMarketScreener.Repo.insert!(%KezanMarketScreener.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias KezanMarketScreener.Repo

alias KezanMarketScreener.Item
alias KezanMarketScreener.Snapshot
alias KezanMarketScreener.Auction

Repo.insert! %Item {
  id: 18803,
  name: "Finkle's Lava Dredger",
  description: "Property of Finkle Einhorn, Grandmaster Adventurer",
  icon: "inv_gizmo_02",
  buy_price: 474384,
  sell_price: 94876,
  is_auctionable: false
}

my_date = Ecto.DateTime.cast!(%{ year: 2016, month: 7, day: 22, hour: 23, minute: 23})

Repo.insert! %Snapshot {
  realm: "Medivh",
  url: "http://auction-api-us.worldofwarcraft.com/auction-data/ab1239c3bc437d48321a64e6b5e5ab7f/auctions.json",
  last_modified: my_date
}

Repo.insert! %Auction {
  id: 1119666568,
  item: 11137,
  owner: "Dreamshade",
  owner_realm: "Exodar",
  bid: 22068,
  buyout: 22068,
  quantity: 1,
  time_left: "VERY_LONG"
}
