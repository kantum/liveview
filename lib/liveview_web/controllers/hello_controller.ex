# While we can name our actions whatever we like, there are conventions for action names which we should follow whenever possible. We went over these in the routing guide, but we'll take another quick look here.

# index - renders a list of all items of the given resource type
# show - renders an individual item by ID
# new - renders a form for creating a new item
# create - receives parameters for one new item and saves it in a data store
# edit - retrieves an individual item by ID and displays it in a form for editing
# update - receives parameters for one edited item and saves the item to a data store
# delete - receives an ID for an item to be deleted and deletes it from a data store
defmodule LiveviewWeb.HelloController do
  use LiveviewWeb, :controller

  plug LiveviewWeb.Plugs.Locale, "fr" when action in [:index]

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"messenger" => messenger}) do
  conn
  # |> Plug.Conn.assign(:messenger, messenger)
  |> assign(:messenger, messenger)
  |> assign(:receiver, "Kantum")
  |> render(:show)
    # render(conn, :show, messenger: messenger)
    # text(conn, "From messenger #{messenger}")
    # json(conn, %{id: messenger})
  end
end
