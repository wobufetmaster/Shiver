defmodule ShiverWeb.CharactersLive do
  alias Bandit.Application
  use ShiverWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, images: list_images())}
  end

  defp list_images do
    # Get the list of image files from the priv/static/characters directoryå
    Path.wildcard("priv/static/user/characters/*") |> Enum.map(fn x -> Path.relative_to(x, "priv/static") end)
  end


  defp get_metadata(img_path) do
    CharacterCard.extract_text(img_path)
  end

  def render(assigns) do
    get_metadata("priv/static/user/characters/rabiella.png")
    ~H"""
    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-4 gap-4">
      <%= for image <- @images do %>
        <div class="flex justify-center items-center">
          <img class="w-full h-auto object-cover rounded-full border-4 hover:border-blue-500 aspect-square" src={image}>
        </div>
      <% end %>
    </div>
    """
  end
end

defmodule CharacterCard do
  def extract_text(file_path) do

    {:ok, char} = File.read(file_path)
    <<137, 80, 78, 71, 13, 10, 26, 10, _rest::binary>> = char

    {pos, _length} = :binary.match(char, "tEXtchara")

    offset = binary_slice(char,pos - 4..pos - 1) |> :binary.decode_unsigned()

    <<"tEXtchara", 0, payload::binary>> = :binary.part(char,{pos, offset + 4})

    Base.decode64!(payload) |> Jason.decode!() |> IO.inspect(label: "Json data")
  end

  def write_text(file_path, content) do
    4
  end

end
