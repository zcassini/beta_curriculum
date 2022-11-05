defmodule Mix.Tasks.Bc.AddBacklinks do
  # use Mix.Task

  # @impl Mix.Task
  def run(_) do
    File.read!("../reading/processes.livemd") |> IO.inspect()

    IO.puts("I RAN!")
  end

  def get_links(data) do
    data
    |> String.replace(~r/## Up Next[\n|.]*/, "")
    |> then(&Regex.scan(~r/[\w|\/|\.]*\w+\.livemd/, &1))
    |> List.flatten()
  end
end
