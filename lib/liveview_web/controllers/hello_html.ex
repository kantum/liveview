defmodule LiveviewWeb.HelloHTML do
  use LiveviewWeb, :html

  # def index(assigns) do
  #   ~H"""
  #   Hello!
  #   """
  # end

  embed_templates "hello_html/*"

  attr :messenger, :string, default: "John"

  def greet(assigns) do
    ~H"""
    <h2 class="rounded-lg bg-green-800 p-2 text-white dark:bg-red-800 ">
      Hello <%= @messenger %>, from Phoenix!
    </h2>
    """
  end
end
