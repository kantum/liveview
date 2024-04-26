defmodule DemoWeb.LinkLive.New do
  use DemoWeb, :live_view

  alias Demo.Links
  alias Demo.Links.Link
  alias Phoenix.PubSub

  @topic inspect(__MODULE__)

  def mount(_params, _session, socket) do
    # user = socket.assigns.current_user
    changeset = Link.changeset(%Link{})

    socket =
      socket
      |> assign(
        :form,
        to_form(changeset)
      )

    {:ok, socket}
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    params =
      link_params
      |> Map.put("user_id", socket.assigns.current_user.id)

    case Links.create_link(params) do
      {:ok, link} ->
        socket =
          socket
          |> put_flash(:info, "Link created successfully.")
          |> push_navigate(to: ~p"/links")

        PubSub.broadcast(Demo.PubSub, @topic, {:link, link})

        {:noreply, socket}

      {:error, changeset} ->
        IO.puts(params)

        socket =
          socket
          |> assign(
            :form,
            to_form(changeset)
          )
          |> put_flash(:error, "error")

        {:noreply, socket}
    end
  end
end
