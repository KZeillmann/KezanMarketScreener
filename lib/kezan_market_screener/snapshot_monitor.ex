defmodule KezanMarketScreener.SnapshotMonitor do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    IO.inspect retrieve_item_info
    {:ok, state}
  end

  defp get_api_key do
    Application.get_env(:kezan_market_screener, KezanMarketScreener.Endpoint)
    |> List.keyfind(:blizzard_api_key, 0)
    |> elem(1)
  end

  defp retrieve_item_info(item_id \\ 18803) do
    url = "https://us.api.battle.net/wow/item/" <> Integer.to_string(item_id) <> "?locale=en_US&apikey=" <> get_api_key
    HTTPoison.get(url)
  end

  def handle_info(:work, state) do
  #   # Do the work you desire here
  #   schedule_work() # Reschedule once more
  #   {:noreply, state}
  end
  #
  # defp schedule_work() do
  #   Process.send_after(self(), :work, 2 * 60 * 60 * 1000) # In 2 hours
  # end
end
