defmodule Chat.StreamController do
  use Chat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end