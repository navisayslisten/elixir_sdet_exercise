defmodule FacebookLoginFailureTest do
  import CustomSelectors
  import DataStructs
  import WaitFunctions
  use Hound.Helpers
  use ExUnit.Case, async: true
  use FacebookLoginCase, async: true

  @email_address "navidekuforest@gmail.com"
  @password_text "P@ssw0rd123"

  setup do
    url = "#{Application.get_env(:elixir_sdet_exercise, :url)}/login"

    case url do
      nil -> nil
      "" -> nil
      _ -> url
    end

    Hound.start_session()
    navigate_to(url)
    :ok
  end

  @tag timeout: :infinity
  test "Login and wait for alternate password page" do
    result = wait_until_false_forever(fn -> login(@email_address, @password_text) end)
    assert(result == false)
  end
end
