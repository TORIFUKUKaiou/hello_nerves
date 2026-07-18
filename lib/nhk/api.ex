defmodule Nhk.Api do
  @apikey Application.compile_env(:hello_nerves, :nhk_api_key)

  def get(area, service, date) do
    case Req.get(url(area, service, date)) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        decoded_body = if is_binary(body), do: Jason.decode!(body), else: body

        decoded_body
        |> Map.get("list")
        |> Map.get(service)

      {:ok, %Req.Response{status: 404}} ->
        IO.puts(404)
        []

      {:error, reason} ->
        IO.inspect(reason)
        []
    end
  end

  defp url(area, service, date) do
    "https://api.nhk.or.jp/v2/pg/list/#{area}/#{service}/#{date}.json?key=#{@apikey}"
  end
end
