defmodule Cloudimg.PageController do
    require Logger
  import Mogrify
  alias Mogrify.Image

  use Cloudimg.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

def image(conn,   %{"size" => size, "imagePath"=> path}) do
        sizePath = "./web/static/assets/images/"<>size<>"/"
        if !File.exists?(sizePath) do
          Logger.info "mkdir"
          File.mkdir(sizePath);
        end
        imageSizePath = "./web/static/assets/images/"<>size<>"/"<>path
        if File.exists?(imageSizePath) do
           body  =  File.read!(imageSizePath)
           text( conn |> put_resp_content_type("image/png ") ,body)
        else
          imagePath = "./web/static/assets/images/"<>path
          if File.exists?(imagePath) do
            image = open(imagePath) |> copy |> resize(size) |> save(imageSizePath) |> verbose
            body  =  File.read!(imageSizePath)
            text( conn |> put_resp_content_type("image/png ") ,body)
        else
          body  =  File.read!("./web/static/assets/images/phoenix2.png")
          text( conn |> put_resp_content_type("image/png ") ,body)
        end


        end

    end
end
