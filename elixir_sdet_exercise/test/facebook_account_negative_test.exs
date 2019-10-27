defmodule FacebookAccountNegativeTest do
  # Import helpers
  import CustomSelectors
  import FileFunctions
  import StringFunctions
  import WaitFunctions
  import List
  use FacebookCase, async: true
  use ExUnit.Case

  # Define vars
  @account_map = get_json("./data/facebook_accounts_negative.json")

  for

  test "Create account with long names" do
    # Fill out all fields, with very long string names
    find_element_by(@first_name) |> fill_field(@long_name)
    find_element_by(@last_name) |> fill_field(@long_name)
    find_element_by(@email) |> fill_field(@random_address)
    find_element_by(@email_confirmation) |> fill_field(@random_address)
    find_element_by(@password) |> fill_field(@random_password)
    select_option(elem(@month, 1), "10")
    select_option(elem(@day, 1), "29")
    select_option(elem(@year, 1), "1929")
    gender_buttons = find_all_elements_by(@gender_buttons)
    first(gender_buttons) |> click()
    find_element_by(@sign_up_button) |> click()

    # Use custom wait until error textbox appears
    error_exists = wait_until_true(fn -> length(find_all_elements_by(@error_textbox)) > 0 end)

    assert error_exists
    error = find_element_by(@error_textbox)

    assert visible_text(error) ==
             "First or last names on Facebook can't have too many characters. Learn more about our name policies."
  end
end
