defmodule StringFunctions do
  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end

  def random_email(length) do
    "#{random_string(length)}@gmail.com"
  end
end
