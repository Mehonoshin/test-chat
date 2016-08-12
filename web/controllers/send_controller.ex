defmodule Chat.SendController do
  use Chat.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"message" => message}) do
    Chat.Endpoint.broadcast!("stream:all", "new_msg", %{message: message})
    conn
    |> put_flash(:info, message)
    |> render("new.html")
  end
end
