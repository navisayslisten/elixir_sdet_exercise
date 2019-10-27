defmodule FacebookAccountNegativeTest do
  # Import helpers
  import CustomSelectors
  import StringFunctions
  import WaitFunctions
  import List
  use Hound.Helpers
  use ExUnit.Case

  # Define vars
  @url "https://www.facebook.com/r.php"
  @long_name "Adolph Blaine Charles David Earl Frederick Gerald Hubert Irvin John Kenneth Lloyd Martin Nero Oliver Paul Quincy Randolph Sherman Thomas Uncas Victor William Xerxes Yancy Zeus Wolfe­schlegel­stein­hausen­berger­dorff­welche­vor­altern­waren­gewissen­haft­schafers­wessen­schafe­waren­wohl­gepflege­und­sorg­faltig­keit­be­schutzen­vor­an­greifen­durch­ihr­raub­gierig­feinde­welche­vor­altern­zwolf­hundert­tausend­jah­res­voran­die­er­scheinen­von­der­erste­erde­mensch­der­raum­schiff­genacht­mit­tung­stein­und­sieben­iridium­elek­trisch­motors­ge­brauch­licht­als­sein­ur­sprung­von­kraft­ge­start­sein­lange­fahrt­hin­zwischen­stern­artig­raum­auf­der­suchen­nach­bar­schaft­der­stern­welche­ge­habt­be­wohn­bar­planeten­kreise­drehen­sich­und­wo­hin­der­neue­rasse­von­ver­stand­ig­mensch­lich­keit­konnte­fort­pflanzen­und­sicher­freuen­an­lebens­lang­lich­freude­und­ru­he­mit­nicht­ein­furcht­vor­an­greifen­vor­anderer­intelligent­ge­schopfs­von­hin­zwischen­stern­art­ig­raum, Senior"
  @random_address random_email(12)
  @random_password random_string(16)
  # Define elements
  @first_name {:name, "firstname"}
  @last_name {:name, "lastname"}
  @email {:name, "reg_email__"}
  @email_confirmation {:name, "reg_email_confirmation__"}
  @password {:name, "reg_passwd__"}
  @month {:id, "month"}
  @day {:id, "day"}
  @year {:id, "year"}
  @gender_buttons {:name, "sex"}
  # @gender_custom_pronoun {:name, "preferred_pronoun"}
  # @gender_custom_field {:name, "custom_gender"}
  @sign_up_button {:name, "websubmit"}
  @error_textbox {:id, "reg_error_inner"}

  # Setup function before each test
  setup do
    Hound.start_session()
    navigate_to(@url)
    IO.inspect("Address: #{@random_address}")
    IO.inspect("Password: #{@random_password}")
    :ok
  end

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
