defmodule LiveviewWeb.HelloController do
  use LiveviewWeb, :controller

  plug LiveviewWeb.Plugs.Locale, "fr" when action in [:index]

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end
end
