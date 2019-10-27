defmodule WaitFunctions do
  def wait_until_true(func, retries \\ 3, ms \\ 1000) when retries >= 0 do
    :timer.sleep(ms)

    # I really hope I did this recursive loop right. Was just for fun.
    case func.() do
      true -> true
      false -> wait_until_true(func, retries - 1)
    end
  end
end
