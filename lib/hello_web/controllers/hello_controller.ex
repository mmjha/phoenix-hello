defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    # render(conn, "index.html")
    conn
    # |> put_root_layout(false)
    # |> put_root_layout("admin.html")
    # |> put_status(202)
    |> render("index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    # render(conn, "show.html", messenger: messenger)
    # text(conn, "From messenger #{messenger}")
    # json(conn, %{id: messenger})
    # conn
    # |> Plug.Conn.assign(:messenger, messenger)
    # |> render("show.html")
    conn
    |> assign(:messenger, messenger)
    |> assign(:receiver, "Dwezil")
    |> render("show.html")
  end

  def test(conn, %{"username" => username}) do
    # render(conn, "test.html", username: username)
    conn
    |> assign(:username, username)
    |> assign(:class, "")
    |> render("test.html")
  end
end
