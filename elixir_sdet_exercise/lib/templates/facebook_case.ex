defmodule FacebookCase do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  # My attempt at "Page Object Pattern"
  using do
    quote do
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
