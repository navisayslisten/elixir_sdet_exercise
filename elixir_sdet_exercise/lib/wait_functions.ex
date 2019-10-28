defmodule WaitFunctions do
  def wait_until_true(func, retries \\ 3, ms \\ 1000) when retries >= 0 do
    :timer.sleep(ms)

    # I really hope I did this recursive loop right. Was just for fun.
    # If true, return true. If false, try again and decrement retry count.
    case func.() do
      true -> true
      false -> wait_until_true(func, retries - 1)
    end
  end

  def wait_until_false(func, retries \\ 3, ms \\ 1000) when retries >= 0 do
    :timer.sleep(ms)

    # I really hope I did this recursive loop right. Was just for fun.
    # If true, return true. If false, try again and decrement retry count.
    case func.() do
      false -> false
      true -> wait_until_false(func, retries - 1)
    end
  end

  def wait_until_false_forever(func, retries \\ 1, ms \\ 1000) when retries >= 0 do
    :timer.sleep(ms)

    # I really hope I did this recursive loop right. Was just for fun.
    # If true, return true. If false, try again and decrement retry count.
    case func.() do
      false -> false
      true -> wait_until_false_forever(func, retries)
    end
  end
end
