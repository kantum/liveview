defmodule LiveviewWeb.HelloHTML do
  use LiveviewWeb, :html

  # def index(assigns) do
  #   ~H"""
  #   Hello!
  #   """
  # end

  embed_templates "hello_html/*"
end
