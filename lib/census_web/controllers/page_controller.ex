defmodule CensusWeb.PageController do
  use CensusWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
