defmodule Qiita.Events.MarkdownGenerator do
  @type items :: list()

  @callback generate(items) :: String.t()

  defmacro __using__(_opts) do
    quote do
      import Qiita.Events.Repo

      def run(query, start_time, end_time, tags, title, id) do
        fetch_items(query, start_time, end_time)
        |> generate()
        |> post_markdown(tags, title, id)
      end
    end
  end
end
