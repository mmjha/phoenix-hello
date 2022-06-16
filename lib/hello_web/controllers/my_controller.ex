#  defmodule HelloWeb.MyController do
#   use Phoenix.Controller

#   action_fallback HelloWeb.MyFallbackController

#   def show(conn, %{"id" => id}, current_user) do
#     with {:ok, post} <- fetch_post(id),
#          :ok <- authorize_user(current_user, :view, post) do
#       render(conn, "show.json", post: post)
#     end
#   end
# end
