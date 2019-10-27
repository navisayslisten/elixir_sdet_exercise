defmodule CustomSelectors do
  use Hound.Helpers

  def select_option(select_id, option) do
    find_element(:css, "##{select_id} option[value='#{option}']") |> click()
  end

  def select_option_within(element, select_id, option) do
    find_within_element(element, :css, "##{select_id} option[value='#{option}']") |> click()
  end

  def find_element_by(tuple_element, retry \\ 5) do
    find_element(elem(tuple_element, 0), elem(tuple_element, 1), retry)
  end

  def find_all_elements_by(tuple_element, retry \\ 5) do
    find_all_elements(elem(tuple_element, 0), elem(tuple_element, 1), retry)
  end
end
