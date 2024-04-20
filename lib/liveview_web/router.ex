defmodule LiveviewWeb.Router do
  use LiveviewWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveviewWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :fetch_current_cart
    plug LiveviewWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveviewWeb do
    pipe_through :browser

    get "/", PageController, :home
    # resources "/users", UserController
    # resources "/posts", PostController, only: [:index, :show]
    # resources "/comments", CommentController, except: [:delete]
    # resources "/reviews", ReviewController
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    get "/redirect_test", PageController, :redirect_test
    resources "/products", ProductController
    resources "/cart_items", CartItemController, only: [:create, :delete]

    get "/cart", CartController, :show
    put "/cart", CartController, :update

    resources "/orders", OrderController, only: [:create, :show]
  end

  # scope "/admin", LiveviewWeb.Admin do
  #   pipe_through :browser
  #
  #   resources "/reviews", ReviewController
  # end

  # scope "/api", LiveviewWeb.Api, as: :api do
  #   pipe_through :api
  #
  #   scope "/v1", V1, as: :v1 do
  #     resources "/images",  ImageController
  #     resources "/reviews", ReviewController
  #     resources "/users",   UserController
  #   end
  # end

  # Other scopes may use custom stacks.
  scope "/api", LiveviewWeb do
    pipe_through :api
    resources "/urls", UrlController, except: [:new, :edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:liveview, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveviewWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp fetch_current_user(conn, _) do
    if user_uuid = get_session(conn, :current_uuid) do
      assign(conn, :current_uuid, user_uuid)
    else
      new_uuid = Ecto.UUID.generate()

      conn
      |> assign(:current_uuid, new_uuid)
      |> put_session(:current_uuid, new_uuid)
    end
  end

  alias Liveview.ShoppingCart

  defp fetch_current_cart(conn, _) do
    if cart = ShoppingCart.get_cart_by_user_uuid(conn.assigns.current_uuid) do
      assign(conn, :cart, cart)
    else
      {:ok, new_cart} = ShoppingCart.create_cart(conn.assigns.current_uuid)
      assign(conn, :cart, new_cart)
    end
  end
end
