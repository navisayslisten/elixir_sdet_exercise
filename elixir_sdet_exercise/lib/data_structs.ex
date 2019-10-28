# Poison is a popular json library for Elixir
defmodule DataStructs do
  @derive [Poison.Encoder]
  defmodule Name do
    defstruct [:first, :last]
  end

  defmodule Email do
    @enforce_keys [:email]
    defstruct [:email]
  end

  defmodule Password do
    @enforce_keys [:password]
    defstruct [:password]
  end
end

defmodule FileReader do
  # Will return content with :ok if it's valid JSON,
  # otherwise returns :error with a reason.
  def read_json_as_struct(filename, data_struct) do
    # Wish I knew how to type-check that data_struct is a struct
    # Remember to ask the interviewers
    filename
    |> File.read!()
    |> Poison.decode!(as: [data_struct])
  end
end
