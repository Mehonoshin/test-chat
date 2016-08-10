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
    res = Chat.Redis.run_query(["SADD", "chat:users:usernames", username])
    redirect conn, to: "/users"
  end
end
