defmodule Qiita.Events.MarkdownGenerator do
  @type items :: list()

  @callback generate(items) :: String.t()

  defmacro __using__(_opts) do
    quote do
      @behaviour Qiita.Events.MarkdownGenerator

      import Qiita.Events.Repo

      def run(opts) do
         query = Access.fetch!(opts, :query)
         start_time = Access.fetch!(opts, :start_time)
         end_time = Access.fetch!(opts, :end_time)
         tags = Access.fetch!(opts, :tags)
         title = Access.fetch!(opts, :title)
         id = Access.fetch!(opts, :id)

        fetch_items(query, start_time, end_time)
        |> __MODULE__.generate()
        |> post_markdown(tags, title, id)
      end
    end
  end
end
