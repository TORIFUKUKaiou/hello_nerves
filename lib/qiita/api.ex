defmodule Qiita.Api do
  @token System.get_env("HELLO_NERVES_QIITA_READ_WRITE_TOKEN")
  @item_id System.get_env("HELLO_NERVES_QIITA_ITEM_ID")
  @headers [
    Authorization: "Bearer #{@token}",
    Accept: "Application/json; Charset=utf-8",
    "Content-Type": "application/json"
  ]
  @options [timeout: 50_000, recv_timeout: 50_000]
  @base_url "https://qiita.com/api/v2"
  @per_page 100

  def items(tags) when is_list(tags) do
    query(tags)
    |> do_items()
  end

  def items(query) when is_bitstring(query) do
    %{"query" => query}
    |> URI.encode_query()
    |> do_items()
  end

  def patch_item(markdown, private, tags, title, item_id \\ @item_id) do
    body =
      %{
        "body" => markdown,
        "private" => private,
        "tags" => tags,
        "title" => title
      }
      |> Jason.encode!()

    HTTPoison.patch!("#{@base_url}/items/#{item_id}", body, @headers)
  end

  defp do_items(query) do
    max_page = total_count(query) |> max_page()

    1..max_page
    |> Enum.reduce([], fn page, acc_list ->
      "#{@base_url}/items?#{query}&per_page=#{@per_page}&page=#{page}"
      |> HTTPoison.get!(@headers, @options)
      |> Map.get(:body)
      |> Jason.decode()
      |> handle_json_decode()
      |> Kernel.++(acc_list)
    end)
  end

  defp query(tags) do
    %{"query" => tags |> Enum.map(&"tag:#{&1}") |> Enum.join(" OR ")}
    |> URI.encode_query()
  end

  defp total_count(query) do
    "#{@base_url}/items?#{query}&per_page=1"
    |> HTTPoison.get!(@headers, @options)
    |> Map.get(:headers)
    |> Enum.filter(fn {key, _} -> key == "Total-Count" end)
    |> Enum.at(0)
    |> elem(1)
    |> String.to_integer()
  end

  defp max_page(total_count) when rem(total_count, @per_page) == 0 do
    div(total_count, @per_page)
    # https://qiita.com/api/v2/docs#%E3%83%9A%E3%83%BC%E3%82%B8%E3%83%8D%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3
    |> min(100)
  end

  defp max_page(total_count) do
    (div(total_count, @per_page) + 1)
    # https://qiita.com/api/v2/docs#%E3%83%9A%E3%83%BC%E3%82%B8%E3%83%8D%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3
    |> min(100)
  end

  defp handle_json_decode({:error, _}), do: []

  defp handle_json_decode({:ok, map}) do
    Enum.map(
      map,
      &Map.take(&1, [
        "title",
        "likes_count",
        "updated_at",
        "created_at",
        "url",
        "user",
        "tags",
        "private"
      ])
    )
    |> Enum.map(fn %{
                     "user" => %{"id" => user_id},
                     "updated_at" => updated_at,
                     "created_at" => created_at,
                     "tags" => tags
                   } = item ->
      updated_at = Timex.parse!(updated_at, "{ISO:Extended}") |> Timex.to_datetime()
      created_at = Timex.parse!(created_at, "{ISO:Extended}") |> Timex.to_datetime()
      tags = Enum.map(tags, &Map.get(&1, "name"))

      item
      |> Map.delete("user")
      |> Map.delete("tags")
      |> Map.merge(%{
        "user_id" => user_id,
        "updated_at" => updated_at,
        "created_at" => created_at,
        "tags" => tags
      })
    end)
    |> Enum.reject(&Map.get(&1, "private"))
  end
end
