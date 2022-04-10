defmodule Qiita.Events.QiitaWishNewFaceTheBest202204Test do
  use ExUnit.Case

  def qiita_items do
    [
      %{
        "title" => "【毎日自動更新】test",
        "likes_count" => 65535,
        "updated_at" => ~U[2022-04-02 18:22:06.038435Z],
        "created_at" => ~U[2022-04-02 18:22:06.038435Z],
        "url" => "https://example.com",
        "user_id" => 255,
        "tags" => ["elixir"]
      }
    ]
  end

  describe "QiitaWishNewFaceTheBest202204.MarkdownGenerator" do
    alias Qiita.Events.QiitaWishNewFaceTheBest202204.MarkdownGenerator

    test "generate/1 generates markdown with qiita items" do
      assert qiita_items() |> MarkdownGenerator.generate() =~ "【毎日自動更新】test"
    end
  end
end
