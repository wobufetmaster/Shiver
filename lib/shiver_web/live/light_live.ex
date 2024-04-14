defmodule ShiverWeb.LightLive do
  use ShiverWeb, :live_view
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
