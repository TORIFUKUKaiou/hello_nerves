defmodule Nhk.Api do
  @apikey Application.get_env(:hello_nerves, :nhk_api_key)

  def get(area, service, date) do
    case HTTPoison.get(url(area, service, date)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("list")
        |> Map.get(service)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts(404)
        []

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        []
    end
  end

  defp url(area, service, date) do
    "https://api.nhk.or.jp/v2/pg/list/#{area}/#{service}/#{date}.json?key=#{@apikey}"
  end
end
