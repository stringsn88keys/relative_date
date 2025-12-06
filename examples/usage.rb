#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/relative_date"

puts "RelativeDate Gem Examples"
puts "=" * 50
puts

# Today's date
puts "Today is: #{Date.today.strftime('%A, %B %d, %Y')}"
puts

# Various examples
examples = [
  "2 Mondays ago",
  "next Friday",
  "last Sunday",
  "3 weeks from now",
  "5 days ago",
  "2 months ago",
  "tomorrow",
  "yesterday",
  "1 year from now"
]

examples.each do |expression|
  result = RelativeDate.parse(expression)
  if result
    puts "#{expression.ljust(20)} => #{result.strftime('%Y-%m-%d (%A)')}"
  else
    puts "#{expression.ljust(20)} => [Could not parse]"
  end
end

puts
puts "=" * 50
puts

# Example with custom reference date
puts "Using custom reference date: Monday, January 15, 2024"
reference = Date.new(2024, 1, 15)
expression = "2 Mondays ago"
result = RelativeDate.parse(expression, reference_date: reference)
puts "#{expression} => #{result.strftime('%Y-%m-%d (%A)')}"
