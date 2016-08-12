defmodule Chat.UserController do
  require Logger

  use Chat.Web, :controller

  plug :set_username

  def index(conn, _params) do
    users = Chat.Users.list()
    online = Chat.Users.online()
    render conn, "index.html", users: users, online_users: online
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"username" => username}) do
    case Chat.Users.SignIn.run(username) do
      {:ok, _username} ->
        conn
        |> put_session(:username, username)
        |> redirect(to: "/users")
      {message, username} ->
        conn
        |> put_flash(:error, "#{message} #{username}")
        |> render("new.html")
    end
  end

  def set_username(conn, _) do
    username = get_session(conn, :username)
    assign(conn, :username, username)
  end
end
