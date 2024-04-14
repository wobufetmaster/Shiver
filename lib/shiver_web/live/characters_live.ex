defmodule ShiverWeb.CharactersLive do
  alias Bandit.Application
  use ShiverWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, images: list_images())}
  end

  defp list_images do
    # Get the list of image files from the priv/static/characters directoryå
    Path.wildcard("priv/static/user/characters/*") |> IO.inspect(label: "Files") |> Enum.map(fn x -> Path.relative_to(x, "priv/static") end)  |> IO.inspect()
  end

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-4 gap-4">
      <%= for image <- @images do %>
        <div class="flex justify-center items-center">
          <img class="w-full h-auto object-cover aspect-square" src={image}>
        </div>
      <% end %>
    </div>
    """
  end
end
