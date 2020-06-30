defmodule Qiita.Api do
  @token System.get_env("HELLO_NERVES_QIITA_READ_WRITE_TOKEN")
  @item_id System.get_env("HELLO_NERVES_QIITA_ITEM_ID")
  @headers [
    Authorization: "Bearer #{@token}",
    Accept: "Application/json; Charset=utf-8",
    "Content-Type": "application/json"
  ]
  @base_url "https://qiita.com/api/v2"
  @per_page 20

  def items(tags \\ ["Elixir", "Nerves", "Phoenix"]) do
    query = query(tags)
    max_page = total_count(query) |> max_page()

    1..max_page
    |> Enum.reduce([], fn page, acc_list ->
      "#{@base_url}/items?#{query}&per_page=#{@per_page}&page=#{page}"
      |> HTTPoison.get!(@headers)
      |> Map.get(:body)
      |> Jason.decode!()
      |> Enum.map(&Map.take(&1, ["title", "likes_count", "updated_at", "url", "user"]))
      |> Enum.map(fn %{"user" => %{"id" => user_id}, "updated_at" => updated_at} = item ->
        updated_at = Timex.parse!(updated_at, "{ISO:Extended}") |> Timex.to_datetime()

        item
        |> Map.delete("user")
        |> Map.merge(%{"user_id" => user_id, "updated_at" => updated_at})
      end)
      |> Kernel.++(acc_list)
    end)
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

  defp query(tags) do
    %{"query" => tags |> Enum.map(&"tag:#{&1}") |> Enum.join(" OR ")}
    |> URI.encode_query()
  end

  defp total_count(query) do
    "#{@base_url}/items?#{query}&per_page=1"
    |> HTTPoison.get!(@headers)
    |> Map.get(:headers)
    |> Enum.filter(fn {key, _} -> key == "Total-Count" end)
    |> Enum.at(0)
    |> elem(1)
    |> String.to_integer()
  end

  defp max_page(total_count) when rem(total_count, @per_page) == 0 do
    div(total_count, @per_page)
    |> min(998)
  end

  defp max_page(total_count) do
    (div(total_count, @per_page) + 1)
    |> min(998)
  end
end
