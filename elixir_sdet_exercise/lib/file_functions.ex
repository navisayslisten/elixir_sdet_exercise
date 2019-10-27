defmodule FileFunctions do
  # Poison is apparently the popular json library for Elixir
  # Will try it out
  @derive [Poison.Decoder]

  # Will return content with :ok if it's valid JSON,
  # otherwise returns :error with a reason.
  def get_json(filename) do
    with {:ok, file_content} <- File.read(filename) do
      Poison.decode(file_content)
    end
  end
end
