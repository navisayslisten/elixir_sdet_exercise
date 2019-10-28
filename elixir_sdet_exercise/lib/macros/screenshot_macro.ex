defmodule ScreenshotMacro do
  import Hound.Helpers.Screenshot

  defmacro sstest(
             test_name,
             macro \\ quote do
               _
             end,
             test_steps
           ) do
    quote do
      test unquote(test_name), unquote(macro) do
        try do
          unquote(test_steps)
        rescue
          error ->
            prefix = String.replace(unquote(test_name), ~r/\W+/, "-")
            IO.inspect("Taking screenshot of failure")
            # Took too long to figure out how to create a directory if it
            # doesn't already exist, so screenshots will override each other
            take_screenshot("screenshots/#{prefix}.png")
            raise error
        end
      end
    end
  end
end
