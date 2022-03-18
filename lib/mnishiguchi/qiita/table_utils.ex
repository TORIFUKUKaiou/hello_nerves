defmodule Mnishiguchi.Qiita.TableUtils do
  def build_table(items) do
    Enum.with_index(items, 1)
    |> Enum.reduce("|No|title|created_at|updated_at|LGTM|\n|---|---|---|---|---:|\n", fn {item,
                                                                                          index},
                                                                                         acc_string ->
      %{
        "title" => title,
        "likes_count" => likes_count,
        "created_at" => created_at,
        "updated_at" => updated_at,
        "url" => url,
        "user_id" => user_id
      } = item

      acc_string <>
        "|#{index}|[#{String.replace(title, "|", "&#124;")}](#{url})<br>@#{user_id}|#{created_at |> Timex.to_date() |> Date.to_string()}|#{updated_at |> Timex.to_date() |> Date.to_string()}|#{Number.Delimit.number_to_delimited(likes_count, precision: 0)}|\n"
    end)
  end

  def build_table_for_util(
         items,
         aggregate \\ &aggregate_by_author/1,
         mapper \\ fn {_, {cnt, _}} -> cnt end,
         header \\ "|No|user|count|LGTM|",
         is_user_id? \\ true,
         first_value_index \\ 0,
         second_value_index \\ 1
       ) do
    aggregate.(items)
    |> Map.to_list()
    |> Enum.sort_by(mapper, :desc)
    |> Enum.with_index(1)
    |> Enum.reduce("#{header}\n|---|---|---:|---:|\n", fn {{key, counts}, index},
                                                          acc_string ->
      first_value = elem(counts, first_value_index)
      second_value = elem(counts, second_value_index)

      acc_string <>
        "|#{index}|#{if(is_user_id?, do: "@", else: "")}#{key}|#{Number.Delimit.number_to_delimited(first_value, precision: 0)}|#{Number.Delimit.number_to_delimited(second_value, precision: 0)}|\n"
    end)
  end

  def aggregate_by_author(items) do
    items
    |> Enum.reduce(%{}, fn %{"user_id" => user_id, "likes_count" => likes_count}, acc ->
      Map.update(acc, user_id, {1, likes_count}, fn {cnt, old_likes_count} ->
        {cnt + 1, old_likes_count + likes_count}
      end)
    end)
  end

  def aggregate_by_tag(items) do
    items
    |> Enum.reduce(%{}, fn %{"tags" => tags, "likes_count" => likes_count}, acc ->
      tags
      |> Enum.reduce(acc, fn tag, acc2 ->
        tag = "[#{tag}](https://qiita.com/tags/#{tag})"

        Map.update(acc2, tag, {1, likes_count}, fn {cnt, old_likes_count} ->
          {cnt + 1, old_likes_count + likes_count}
        end)
      end)
    end)
  end
end
