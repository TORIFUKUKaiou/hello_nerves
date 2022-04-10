defmodule Qiita.Events.MarkdownGenerator do
  @type items :: list()

  @callback generate(items) :: String.t()
end
