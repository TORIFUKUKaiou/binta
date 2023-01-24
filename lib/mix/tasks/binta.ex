defmodule Mix.Tasks.Binta do
  @moduledoc "The binta mix task: `mix help binta`"
  use Mix.Task

  def run(["闘魂"]) do
    Mix.Task.run("app.start")
    Binta.run()
  end
end
