defmodule BlizzardAPIHelper do
  require Logger

  import Ecto.Query
  @server "Stormrage"
  @wow_api_url "https://us.api.battle.net/wow/"

  def download_new_snapshot do
    retrieve_snapshot_info()
  end

  defp get_api_key do
    Application.get_env(:kezan_market_screener, KezanMarketScreener.Endpoint)
    |> List.keyfind(:blizzard_api_key, 0)
    |> elem(1)
  end

  defp retrieve_snapshot_info(server \\ @server) do
    url = @wow_api_url <> "auction/data/" <> server <> "?locale=en_US&apikey=" <> get_api_key()
    {:ok, response} = HTTPoison.get(url)
    raw_json = Poison.decode!(response.body)
    dump_data = raw_json["files"] |> List.first
    modified_date = dump_data["lastModified"]
    #last_modified = DateTime.from_unix(modified_date, :milliseconds)
    current_file = "current_auction_#{modified_date}.json"
    unless File.exists?(current_file) do
      Logger.debug "Updating current auction data"
      url = dump_data["url"]
      save_snapshot_dump(url, modified_date)
    else
      Logger.debug "Auction file is up to date."
      parse_dump_json(current_file)
    end
  end

  defp save_snapshot_dump(url, modified_date) do
    Logger.debug "Getting auction info from #{url}"
    {:ok, response} = HTTPoison.get(url)
    Logger.debug "Json retrieved. Writing to file."
    filename = "current_auction_#{modified_date}.json"
    File.write(filename, response.body, [:write])
    Logger.debug "Done writing!"
    parse_dump_json(filename)
  end

  defp parse_dump_json(filename) do
    Logger.debug "Parsing auction dump"
    file_contents = File.read!(filename)
    raw_json = Poison.decode!(file_contents)
    auctions = raw_json["auctions"]
    |> retrieve_items_from_dump
    |> save_unpersisted_items

    raw_json["auctions"]
    |> save_auctions
  end

  defp save_auctions(auction_data) do
    Logger.debug "Saving auction data"
    IO.inspect auction_data
    Logger.debug "Auction data inspected"
  end

  # returns all unique items in the dump
  defp retrieve_items_from_dump(auctions) do
    auctions
    |> Enum.map(fn(x) -> x["item"] end)
    |> Enum.sort
    |> Enum.dedup
  end

  defp save_unpersisted_items(items) do
    persisted_item_ids = all_item_ids()
    items
    |> Enum.filter(fn(item) -> not Enum.member?(persisted_item_ids, item) end)
    # |> IO.inspect
    |> Enum.map(&retrieve_item_info/1)
  end

  defp all_item_ids do
    KezanMarketScreener.Repo.all(from i in "items",
      select: i.id
    )
  end

  defp save_item_data(item) do
    Logger.debug "Saving item with id #{item.id}"
    KezanMarketScreener.Repo.insert item
  end

  defp retrieve_item_info(item_id) do
    url = @wow_api_url <> "item/" <> Integer.to_string(item_id) <> "?locale=en_US&apikey=" <> get_api_key()
    Logger.debug "Querying for item with id #{item_id}"
    case HTTPoison.get(url) do
      {:ok, response} -> decode_and_save_item(response)
      {:error, %HTTPoison.Error{id: _, reason: reason}} -> sleep_and_retry(item_id, reason)
    end
  end

  defp sleep_and_retry(item_id, reason) do
    Logger.error "Could not retrieve item with id of #{item_id} because of #{reason}"
    Process.sleep(1000)
    retrieve_item_info(item_id)
  end

  defp decode_and_save_item(item_response) do
    if item_response.status_code == 200 do
      raw_json = Poison.decode!(item_response.body)
      item = %KezanMarketScreener.Item{
        id: raw_json["id"],
        name: raw_json["name"],
        description: raw_json["description"],
        icon: raw_json["icon"],
        buy_price: raw_json["buyPrice"],
        sell_price: raw_json["sellPrice"],
        is_auctionable: raw_json["isAuctionable"]
      }
      save_item_data(item)
    end
  end
end
