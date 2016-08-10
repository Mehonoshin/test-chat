defmodule Chat.Redis do
  import Exredis

  def run_query(q), do: start_link() |> elem(1) |> query(q)
end
