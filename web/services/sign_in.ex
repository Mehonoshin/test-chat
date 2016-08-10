defmodule Chat.SignIn do
  def run(username) do
    case {valid_username?(username), not_taken?(username)} do
      {true, true} ->
        Chat.Redis.run_query(["SADD", "chat:users:usernames", username])
        {:ok, username}
      {false, _} ->
        {:invalid_username, username}
      {_, false} ->
        {:username_already_taken, username}
    end
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
end
