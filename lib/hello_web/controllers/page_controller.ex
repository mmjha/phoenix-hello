defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  plug HelloWeb.Plugs.Locale, "en" when action in [:index]

  def index(conn, _params) do
    # conn
    # |> put_resp_content_type("text/xml")
    # |> render("index.xml", content: some_xml_content)
    # render(conn, "index.html")
    # redirect(conn, to: "/redirect_test")
    # redirect(conn, external: "https://elixir-lang.org/")
    # redirect(conn, to: Routes.page_path(conn, :redirect_test))
    # conn
    # |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    # |> put_flash(:error, "Let's pretend we have an error.")
    # |> redirect(to: Routes.page_path(conn, :redirect_test))
    # render(conn, "index.html")
    pages = [%{title: "foo"}, %{title: "bar"}]
    render(conn, "index.json", pages: pages)
  end

  def show(conn, _params) do
    page = %{title: "foo"}
    render(conn, "show.json", page: page)
  end

  def redirect_test(conn, _params) do
    render(conn, "index.html")
  end

  def home(conn, _params) do
    render(conn, "index.html")
  end
end
