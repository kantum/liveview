defmodule Mix.Tasks.Greeting do
  use Mix.Task

  @shortdoc "Sends a greeting to us from Phoenix"

  @moduledoc """
  This is where we would put any long form documentation and doctests.
  """

  @requirements ["app.start"]

  @impl Mix.Task
  def run(_args) do
    Mix.shell().info("Greetings from the Phoenix Application")
  end
end
