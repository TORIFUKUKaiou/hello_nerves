defmodule TwitterSearch.Worker do
  use GenServer

  @one_minute 60 * 1000
  @interval Application.compile_env(:hello_nerves, :twitter_search_interval)
  @query Application.compile_env(:hello_nerves, :twitter_query)
  @last_created_at Application.compile_env(:hello_nerves, :twitter_last_created_at)
  @incoming_webhook_url Application.compile_env(:hello_nerves, :slack_incoming_webhook_url)
  @channel Application.compile_env(:hello_nerves, :slack_channel)

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_state) do
    Process.send_after(__MODULE__, :tick, @one_minute)
    {:ok, %{last_created_at: @last_created_at}}
  end

  def handle_info(:tick, %{last_created_at: last_created_at}) do
    Process.send_after(__MODULE__, :tick, @interval)

    new_last_created_at = run(last_created_at)

    {:noreply, %{last_created_at: new_last_created_at}}
  end

  def handle_call(:current_state, _from, current_state),
    do: {:reply, current_state, current_state}

  def current_state, do: GenServer.call(__MODULE__, :current_state)

  def run(last_created_at) do
    list = do_search(last_created_at)
    list |> Enum.sort_by(& &1.created_at) |> Enum.map(&do_post/1)

    case Enum.count(list) do
      0 ->
        last_created_at

      _ ->
        list |> Enum.map(& &1.created_at) |> Enum.max()
    end
  end

  def do_search(last_created_at) do
    response =
      ExTwitter.search(
        @query,
        count: 100,
        search_metadata: true
      )

    response.statuses
    |> statuses(last_created_at)
    |> do_search_next_page(response.metadata, last_created_at, [])
  end

  defp do_search_next_page([], _metadata, _last_created_at, result_list), do: result_list

  defp do_search_next_page(prev_page_list, metadata, last_created_at, result_list) do
    response = ExTwitter.search_next_page(metadata)

    response.statuses
    |> statuses(last_created_at)
    |> do_search_next_page(response.metadata, last_created_at, result_list ++ prev_page_list)
  end

  defp statuses(statuses, last_created_at) do
    statuses
    |> Enum.map(fn %{
                     id_str: id_str,
                     text: text,
                     created_at: created_at,
                     user: %{
                       profile_image_url_https: profile_image_url_https,
                       screen_name: screen_name
                     }
                   } ->
      %{
        text: text,
        created_at:
          Timex.parse!(created_at, "{WDshort} {Mshort} {D} {h24}:{m}:{s} +0000 {YYYY}")
          |> Timex.to_unix(),
        profile_image_url_https: profile_image_url_https,
        screen_name: screen_name,
        url: "https://twitter.com/#{screen_name}/status/#{id_str}"
      }
    end)
    |> Enum.filter(fn %{created_at: created_at} -> created_at > last_created_at end)
  end

  defp do_post(%{
         text: text,
         created_at: created_at,
         profile_image_url_https: profile_image_url_https,
         url: url,
         screen_name: screen_name
       }) do
    body =
      %{
        text: "#{text}\n#{url}\n(#{created_at})",
        username: screen_name,
        icon_url: profile_image_url_https,
        link_names: 1,
        channel: @channel
      }
      |> Jason.encode!()

    headers = [{"Content-type", "application/json"}]
    HTTPoison.post!(@incoming_webhook_url, body, headers)
  end
end
