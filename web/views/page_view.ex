defmodule Chat.PageView do
  use Chat.Web, :view

  def format_redis_keys(data) do
    [data | "123"]
  end
end
