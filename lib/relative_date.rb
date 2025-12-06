# frozen_string_literal: true

require_relative "relative_date/version"
require_relative "relative_date/parser"

module RelativeDate
  class Error < StandardError; end

  # Parse a relative time expression and return a Date
  #
  # @param input [String] the relative time expression (e.g., "2 Mondays ago")
  # @param reference_date [Date] the date to calculate from (defaults to today)
  # @return [Date, nil] the calculated date, or nil if the input can't be parsed
  def self.parse(input, reference_date: Date.today)
    Parser.new(input, reference_date: reference_date).parse
  end

  # Parse a relative time expression and return a Date, raising an error if parsing fails
  #
  # @param input [String] the relative time expression
  # @param reference_date [Date] the date to calculate from (defaults to today)
  # @return [Date] the calculated date
  # @raise [Error] if the input can't be parsed
  def self.parse!(input, reference_date: Date.today)
    result = parse(input, reference_date: reference_date)
    raise Error, "Unable to parse '#{input}'" if result.nil?

    result
  end
end
