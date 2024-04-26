defmodule DemoWeb.LinkLive.Index do
  use DemoWeb, :live_view

  alias Phoenix.PubSub
  alias Demo.Links

  # @topic inspect(__MODULE__)

  def mount(_params, _session, socket) do
    if connected?(socket) do
      PubSub.subscribe(Demo.PubSub, "DemoWeb.LinkLive.New")
    end

    user_id = socket.assigns.current_user.id

    socket =
      socket
      |> assign(:links, Links.list_links(user_id))

    {:ok, socket}
  end

  def handle_info({:link, link}, socket) do
    {:noreply, update(socket, :links, &[link | &1])}
  end
end
