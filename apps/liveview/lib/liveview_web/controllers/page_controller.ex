defmodule LiveviewWeb.PageController do
  use LiveviewWeb, :controller

  # def home(conn, _params) do
  #   render(conn, :home, layout: false)
  # end

  # Setting the content type
  # def home(conn, _params) do
  #   conn
  #   |> put_resp_content_type("text/plain")
  #   |> send_resp(201, "")
  # end

  # Setting the HTTP Status
  # def home(conn, _params) do
  #   conn
  #   |> put_status(202)
  #   |> render(:home, layout: false)
  # end

  # Redirection
  # def home(conn, _params) do
  #   redirect(conn, to: ~p"/redirect_test")
  # end
  # def redirect_test(conn, _params) do
  #   render(conn, :home, layout: false)
  # end
  # def home(conn, _params) do
  #   redirect(conn, external: "https://elixir-lang.org/")
  # end

  def home(conn, _params) do
    conn
    |> put_flash(:warning, "We have a problem")
    |> render(:home, layout: false)
  end

  # def home(conn, _params) do
  #   conn
  #   |> put_flash(:warning, "Let's pretend we have an error.")
  #   |> redirect(to: ~p"/redirect_test")
  # end

  def redirect_test(conn, _params) do
    render(conn, :home, layout: false)
  end
end
