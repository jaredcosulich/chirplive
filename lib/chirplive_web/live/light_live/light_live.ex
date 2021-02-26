defmodule ChirpliveWeb.LightLive do
  use ChirpliveWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :brightness, 10)}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
    <div class="meter">
      <span style="width: <%= @brightness %>%">
        <%= @brightness %>%
      </span>
    </div>
    <button phx-click="off">
      Off
    </button>

    <button phx-click="on">
      On
    </button>

    &nbsp; &nbsp; &nbsp;

    <button phx-click="down">
      Down
    </button>

    <button phx-click="up">
      Up
    </button>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end

  def handle_event("down", _, socket) do
    {:noreply, update(socket, :brightness, &max(&1 - 10, 0))}
  end

  def handle_event("up", _, socket) do
    {:noreply, update(socket, :brightness, &min(&1 + 10, 100))}
  end
end
