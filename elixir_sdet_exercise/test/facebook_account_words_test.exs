defmodule FacebookAccountWordsTest do
  import CustomSelectors
  import DataStructs
  import FileReader
  import WaitFunctions
  use Hound.Helpers
  use ExUnit.Case, async: true
  use FacebookCase, async: true

  @too_many_words read_json_as_struct(
                    Path.join(__DIR__, "data/facebook_too_many_words.json"),
                    %DataStructs.Name{}
                  )

  for name <- @too_many_words do
    @first_name name.first
    @last_name name.last
    @email_address "elixir_sdet_exercise@gmail.com"
    @password_text "P@ssw0rd123"
    @month_value "10"
    @day_value "29"
    @year_value "1929"

    test "Too many words #{String.slice(@first_name, 0..31)} #{String.slice(@last_name, 0..31)}" do
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
      assert error_exists
      error = find_element_by(@error_textbox)

      assert visible_text(error) ==
               "Names on Facebook can't have too many words. Learn more about our name policies."
    end
  end
end
