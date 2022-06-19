defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HelloWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :fetch_current_cart
    plug HelloWeb.Plugs.Locale, "en"
  end

  defp fetch_current_user(conn, _) do
    if user_uuid = get_session(conn, :current_uuid) do
      assign(conn, :current_uuid, user_uuid)
    else
      new_uuid = Ecto.UUID.generate()

      conn
      |> assign(:current_uuid, new_uuid)
      |> put_session(:curent_uuid, new_uuid)
    end
  end

  alias Hello.ShoppingCart

  def fetch_current_cart(conn, _opts) do
    if cart = ShoppingCart.get_cart_by_user_uuid(conn.assigns.current_uuid) do
      assign(conn, :cart, cart)
    else
      {:ok, new_cart} = ShoppingCart.create_cart(conn.assigns.current_uuid)
      assign(conn, :cart, new_cart)
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :review_checks do
    plug :browser
    # plug :ensure_authenticated_user
    # plug :ensure_user_owns_review
  end

  scope "/", HelloWeb do
    pipe_through :browser
    # pipe_through [:authenticate_user, :ensure_admin]
    # forward "/jobs", BackgroundJob.Plug

    get "/", PageController, :index
    # get "/show", PageController, :show
    # get "/hello", HelloController, :index
    # get "/hello/:messenger", HelloController, :show
    # get "/hello/test/:username", HelloController, :test
    # get "/redirect_test", PageController, :redirect_test
    # resources "/comments", CommentController, except: [:delete]
    # resources "/reviews", ReviewController
    # resources "/users", UserController do
    #   resources "/posts", PostController, only: [:index, :show]
    # end

    resources "/products", ProductController
    resources "/cart_items", CartItemController, only: [:create, :delete]

    get "/cart", CartController, :show
    put "/cart", CartController, :update
  end

  # scope "/", AnotherAppWeb do
  #   pipe_through :browser

  #   resources "/posts", PostController
  # end

  # scope "/reviews", HelloWeb do
  #   pipe_through :review_checks

  #   resources "/", ReviewController
  # end

  # scope "/admin", HelloWeb.Admin, as: :admin do
  #   pipe_through :browser

  #   resources "/images", ImageController
  #   resources "/reviews", ReviewController
  #   resources "/users", UserController
  # end

  # scope "/api", HelloWeb.Api, as: :api do
  #   pipe_through :api

  #   scope "/v1", V1, as: :v1 do
  #     resources "/images", ImageController
  #     resources "/reviews", ReviewController
  #     resources "/users", UserController
  #   end
  # end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
