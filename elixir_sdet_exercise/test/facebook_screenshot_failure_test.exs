defmodule FacebookScreenshotFailureTest do
  import CustomSelectors
  import DataStructs
  import FileReader
  import WaitFunctions

  use Hound.Helpers
  use ExUnit.Case, async: true
  use FacebookCase, async: true

  @long_names read_json_as_struct(
                Path.join(__DIR__, "data/facebook_invalid_names.json"),
                %DataStructs.Name{}
              )

  # These tests should generate 4 failure screenshots
  for name <- @long_names do
    @first_name name.first
    @last_name name.last
    @email_address "elixir_sdet_exercise@gmail.com"
    @password_text "P@ssw0rd123"
    @month_value "10"
    @day_value "29"
    @year_value "1929"

    sstest "Invalid names #{String.slice(@first_name, 0..31)} #{String.slice(@last_name, 0..31)}" do
      create_basic_account(
        @first_name,
        @last_name,
        @email_address,
        @password_text,
        @month_value,
        @day_value,
        @year_value
      )

      # Use custom wait until error textbox appears
      error_exists = wait_until_true(fn -> length(find_all_elements_by(@error_textbox)) > 0 end)
      assert(error_exists)
      error = find_element_by(@error_textbox)

      assert(
        visible_text(error) ==
          "First or last names on Facebook can't have too many characters. Learn more about our name policies."
      )
    end
  end
end
