defmodule Chat.UserController do
  require Logger
  use Chat.Web, :controller

  def index(conn, _params) do
    users = Chat.Redis.run_query(["SMEMBERS", "chat:users:usernames"])
    render conn, "index.html", users: users
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"username" => username} = params) do
    case Chat.SignIn.run(username) do
      {:ok, username} ->
        redirect conn, to: "/users"
      {message, username} ->
        conn
        |> put_flash(:error, "#{message} #{username}")
        |> render "new.html"
    end
  end
end
