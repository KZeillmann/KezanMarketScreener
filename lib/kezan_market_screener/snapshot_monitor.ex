defmodule KezanMarketScreener.SnapshotMonitor do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    BlizzardAPIHelper.download_new_snapshot
    # those_items = Enum.map(truncated_items, &retrieve_item_info/1)
    Logger.info "All done!"
    # save_unpersisted_items those_items
    {:ok, state}
  end

  def handle_info(:work, state) do
    state
  #   # Do the work you desire here
  #   schedule_work() # Reschedule once more
  #   {:noreply, state}
  end
  #
  # defp schedule_work() do
  #   Process.send_after(self(), :work, 2 * 60 * 60 * 1000) # In 2 hours
  # end
end
