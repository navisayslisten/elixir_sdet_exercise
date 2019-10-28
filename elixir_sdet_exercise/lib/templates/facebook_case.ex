defmodule FacebookCase do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  # My attempt at "Page Object Pattern"
  using do
    quote do
      import ScreenshotMacro
      @first_name_field {:name, "firstname"}
      @last_name_field {:name, "lastname"}
      @email_field {:name, "reg_email__"}
      @email_confirmation_field {:name, "reg_email_confirmation__"}
      @password_field {:name, "reg_passwd__"}
      @month_field {:id, "month"}
      @day_field {:id, "day"}
      @year_field {:id, "year"}
      @gender_buttons {:name, "sex"}
      @gender_custom_pronoun_field {:name, "preferred_pronoun"}
      @gender_custom_field {:name, "custom_gender"}
      @sign_up_button {:name, "websubmit"}
      @error_textbox {:id, "reg_error_inner"}

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

      hound_session()
    end
  end

  setup do
    url = Application.get_env(:elixir_sdet_exercise, :url)

    case url do
      nil -> nil
      "" -> nil
      _ -> url
    end

    Hound.start_session()
    navigate_to(url)
    :ok
  end
end
