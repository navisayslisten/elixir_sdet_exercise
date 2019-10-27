defmodule FacebookCase do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  # My attempt at "Page Object Pattern"
  using do
    quote do
      @first_name {:name, "firstname"}
      @last_name {:name, "lastname"}
      @email {:name, "reg_email__"}
      @email_confirmation {:name, "reg_email_confirmation__"}
      @password {:name, "reg_passwd__"}
      @month {:id, "month"}
      @day {:id, "day"}
      @year {:id, "year"}
      @gender_buttons {:name, "sex"}
      @gender_custom_pronoun {:name, "preferred_pronoun"}
      @gender_custom_field {:name, "custom_gender"}
      @sign_up_button {:name, "websubmit"}
      @error_textbox {:id, "reg_error_inner"}
    end
  end

  setup do
    url = Application.get_env(:facebook, :url)

    case url do
      nil -> nil
      "" -> nil
      _ -> url
    end

    Hound.start_session()
    navigate_to(url)
  end
end
