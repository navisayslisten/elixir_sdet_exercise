defmodule FacebookLoginCase do
  use ExUnit.CaseTemplate
  use Hound.Helpers

  # My attempt at "Page Object Pattern"
  using do
    quote do
      import ScreenshotMacro
      @email_field {:id, "email"}
      @password_field {:id, "pass"}
      @login_button {:id, "loginbutton"}
      @error_textbox {:css, "div[role='alert']"}

      def login(email, password) do
        find_element_by(@email_field) |> fill_field(email)
        find_element_by(@password_field) |> fill_field(password)
        find_element_by(@login_button) |> click()
        login_exists = wait_until_true(fn -> length(find_all_elements_by(@email_field)) > 0 end)
      end

      hound_session()
    end
  end
end
