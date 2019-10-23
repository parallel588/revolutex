ExUnit.start()

defmodule Helper do
  @fixture_path "./test/fixtures/"

  def load_fixture(filename) do
    (@fixture_path <> filename)
    |> File.read!()
    |> Jason.decode!()
  end

  def client(token \\ "sand_g6Q") do
    Revolutex.client(token)
  end
end
