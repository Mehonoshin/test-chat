defmodule Chat.PageController do
  use Chat.Web, :controller

  def index(conn, _params) do
    data = Chat.Redis.run_query(["keys", "*"])
    render conn, "index.html", data: data
  end
end
