defmodule ChirpliveWeb.LightLiveTest do
  use ChirpliveWeb.ConnCase
  import Phoenix.LiveViewTest

  test "it connects and renders", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/light")
    assert html =~ "<h1>Front Porch Light</h1>"
  end

  test "turn the light on and off", %{conn: conn} do
    {:ok, view, html} = live(conn, "/light")

    assert html =~ "10%"

    assert view
           |> element("button", "On")
           |> render_click() =~ "100%"

    assert view
           |> element("button", "Off")
           |> render_click() =~ "0%"
  end

  test "turn the light up and down", %{conn: conn} do
    {:ok, view, html} = live(conn, "/light")

    assert html =~ "10%"

    assert view
           |> element("button", "Up")
           |> render_click() =~ "20%"

    assert view
           |> element("button", "Up")
           |> render_click() =~ "30%"

    assert view
           |> element("button", "Down")
           |> render_click() =~ "20%"

    assert view
           |> element("button", "Down")
           |> render_click() =~ "10%"
  end
end
