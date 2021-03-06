defmodule HelloWeb.PageView do
  use HelloWeb, :view
  alias HelloWeb.AuthorView

  # def render("index.html", assigns) do
  #   "rendering with assigns #{inspect Map.keys(assigns)}"
  # end

  def render("index.json", %{pages: pages}) do
    # %{data: Enum.map(pages, fn page -> %{title: page.title} end)}
    %{data: render_many(pages, HelloWeb.PageView, "page.json")}
  end

  def render("show.json", %{page: page}) do
    # %{data: %{title: page.title}}
    %{data: render_one(page, HelloWeb.PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{title: page.title}
  end

  def render("page_with_authors.json", %{page: page}) do
    %{title: page.title,
      authors: render_many(page.authors, AuthorView, "author.json", as: :writer)}
  end
end
