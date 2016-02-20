defmodule Cloudimg.PageController do
  import Mogrify
  alias Mogrify.Image

  use Cloudimg.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def image(conn, _params) do
     image = open("./web/static/assets/images/phoenix.png") |> copy |> resize("400x100") |> save("./web/static/assets/images/phoenix2.png") |> verbose
       body  =  File.read!("./web/static/assets/images/phoenix2.png")
     # data = body
          render conn, "index.html", message: "test", image: "/images/phoenix2.png"
  end
end
