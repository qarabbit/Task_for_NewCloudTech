module Environment

  # Makes text in cucumber table red
  def red_cell(string)
    # Here is hidden symbol "" before [31m and [0m
    "[31m #{string} [0m"
  end

  # Makes text in cucumber table red
  def green_cell(string)
    # Here is hidden symbol "" before [32m and [0m
    "[32m #{string} [0m"
  end

  # if skip = true do not visit page if it's the same
  def visit_page(link, skip = false)
    return if skip && (link == current_url)
    visit link
    sleep 1
  end
end
World(Environment)
