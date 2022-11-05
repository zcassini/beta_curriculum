defmodule Mix.Tasks.Bc.AddBacklinksTest do
  use ExUnit.Case
  doctest Mix.Tasks.Bc.AddBacklinks
  alias Mix.Tasks.Bc.AddBacklinks

  # ## Up Next

  # | Previous                                                       | Next                                                 |
  # | -------------------------------------------------------------- | ---------------------------------------------------: |
  # | [Fibonacci Challenge](../exercises/fibonacci_challenge.livemd) | [Process Drills](../exercises/process_drills.livemd) |
  test "generate backlinks" do
    content = """
    * [Name](name.livemd)
    """

    assert AddBacklinks.get_links(content) == ["name.livemd"]
  end

  test "get_links/1 return filenames" do
    content = """
    * [Name](name.livemd)
    * [File2](file2.livemd)
    """

    assert AddBacklinks.get_links(content) == ["name.livemd", "file2.livemd"]
  end

  test "get_links/1 return filenames including path" do
    content = """
    * [Name](../path_example/name.livemd)
    * [File2](file2.livemd)
    """

    assert AddBacklinks.get_links(content) == ["../path_example/name.livemd", "file2.livemd"]
  end

  test "get_links/1 ignore navigation links" do
    content = """
    * [Name](../path_example/name.livemd)
    * [File2](file2.livemd)


    ## Up Next

    | Previous                                                       | Next                                                 |
    | -------------------------------------------------------------- | ---------------------------------------------------: |
    | [Fibonacci Challenge](../exercises/fibonacci_challenge.livemd) | [Process Drills](../exercises/process_drills.livemd) |
    """

    assert AddBacklinks.get_links(content) == ["../path_example/name.livemd", "file2.livemd"]
  end

  test "get_links/1 exclude empty filenames" do
    content = """
    * [Name](../path_example/.livemd)
    * [File2](file2.livemd)
    """

    assert AddBacklinks.get_links(content) == ["file2.livemd"]
  end
end
