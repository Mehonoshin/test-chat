defmodule Chat.Users.SignIn do
  def run(username) do
    validation = {valid_username?(username), not_taken?(username)}
    _run(validation, username)
  end

  def valid_username?(username) do
    Regex.match?(~r/^[\w]{1,20}$/, username)
  end

  def not_taken?(username) do
    taken = Chat.Redis.run_query(["SISMEMBER", "chat:users:taken_usernames", username])

    case taken do
      "0" ->
        true
      _ ->
        false
    end
  end

  def _run({true, true}, username) do
    Chat.Redis.run_query(["SREM", "chat:users:usernames", username])
    Chat.Redis.run_query(["SADD", "chat:users:taken_usernames", username])
    {:ok, username}
  end

  def _run({false, _}, username) do
    {:invalid_username, username}
  end

  def _run({_, false}, username) do
    {:username_already_taken, username}
  end
end
