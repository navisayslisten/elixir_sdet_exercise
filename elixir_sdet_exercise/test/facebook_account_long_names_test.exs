defmodule FacebookAccountLongNamesTest do
  import CustomSelectors
  import DataStructs
  import FileReader
  import WaitFunctions
  use Hound.Helpers
  use ExUnit.Case, async: true
  use FacebookCase, async: true

  def create_basic_account(first, last, email, password, month, day, year) do
    find_element_by(@first_name_field) |> fill_field(first)
    find_element_by(@last_name_field) |> fill_field(last)
    find_element_by(@email_field) |> fill_field(email)
    find_element_by(@email_confirmation_field) |> fill_field(email)
    find_element_by(@password_field) |> fill_field(password)
    select_option(elem(@month_field, 1), month)
    select_option(elem(@day_field, 1), day)
    select_option(elem(@year_field, 1), year)
    gender_buttons = find_all_elements_by(@gender_buttons)
    Enum.at(gender_buttons, 0) |> click()
    find_element_by(@sign_up_button) |> click()
  end

  @long_names read_json_as_struct(
                Path.join(__DIR__, "data/facebook_long_names.json"),
                %DataStructs.Name{}
              )

  for name <- @long_names do
    @first_name name.first
    @last_name name.last
    @email_address "elixir_sdet_exercise@gmail.com"
    @password_text "P@ssw0rd123"
    @month_value "10"
    @day_value "29"
    @year_value "1929"

    test "Long names #{String.slice(@first_name, 0..31)} #{String.slice(@last_name, 0..31)}" do
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
               "First or last names on Facebook can't have too many characters. Learn more about our name policies."
    end
  end
end
