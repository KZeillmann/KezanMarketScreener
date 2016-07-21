ExUnit.start

Mix.Task.run "ecto.create", ~w(-r KezanMarketScreener.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r KezanMarketScreener.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(KezanMarketScreener.Repo)

