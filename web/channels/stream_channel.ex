defmodule Chat.StreamChannel do
  use Phoenix.Channel

  def join("stream:all", _message, socket) do
    {:ok, socket}
  end
end
