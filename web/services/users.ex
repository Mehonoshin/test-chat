defmodule Chat.Users do
  def list() do
    users = Chat.Redis.run_query(["SMEMBERS", "chat:users:usernames"])
  end

  def online() do
    users = Chat.Redis.run_query(["SMEMBERS", "chat:users:taken_usernames"])
  end
end
