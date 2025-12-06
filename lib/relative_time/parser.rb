# frozen_string_literal: true

require "date"
require "time"

module RelativeTime
  class Parser
    WEEKDAYS = {
      "monday" => 1,
      "tuesday" => 2,
      "wednesday" => 3,
      "thursday" => 4,
      "friday" => 5,
      "saturday" => 6,
      "sunday" => 0
    }.freeze

    UNITS = {
      "day" => :days,
      "days" => :days,
      "week" => :weeks,
      "weeks" => :weeks,
      "month" => :months,
      "months" => :months,
      "year" => :years,
      "years" => :years
    }.freeze

    def initialize(input, reference_date: Date.today)
      @input = input.downcase.strip
      @reference_date = reference_date
    end

    def parse
      return nil if @input.empty?

      # Try to match different patterns
      parse_weekday_pattern ||
        parse_simple_relative ||
        parse_unit_relative ||
        parse_next_last_weekday ||
        parse_today_tomorrow_yesterday ||
        nil
    end

    private

    # Matches patterns like "2 Mondays ago", "3 fridays from now"
    def parse_weekday_pattern
      match = @input.match(/^(\d+)\s+(monday|tuesday|wednesday|thursday|friday|saturday|sunday)s?\s+(ago|from\s+now)$/i)
      return nil unless match

      count = match[1].to_i
      weekday = match[2].downcase
      direction = match[3].downcase

      target_wday = WEEKDAYS[weekday]
      current_date = @reference_date
      found_count = 0

      if direction == "ago"
        # Go backwards
        loop do
          current_date -= 1
          found_count += 1 if current_date.wday == target_wday
          break if found_count == count
        end
      else
        # Go forwards
        loop do
          current_date += 1
          found_count += 1 if current_date.wday == target_wday
          break if found_count == count
        end
      end

      current_date
    end

    # Matches patterns like "next Monday", "last Friday"
    def parse_next_last_weekday
      match = @input.match(/^(next|last)\s+(monday|tuesday|wednesday|thursday|friday|saturday|sunday)$/i)
      return nil unless match

      direction = match[1].downcase
      weekday = match[2].downcase
      target_wday = WEEKDAYS[weekday]

      current_date = @reference_date

      if direction == "next"
        # Find the next occurrence of this weekday
        loop do
          current_date += 1
          break if current_date.wday == target_wday
        end
      else # last
        # Find the previous occurrence of this weekday
        loop do
          current_date -= 1
          break if current_date.wday == target_wday
        end
      end

      current_date
    end

    # Matches patterns like "3 days ago", "2 weeks from now"
    def parse_unit_relative
      match = @input.match(/^(\d+)\s+(day|days|week|weeks|month|months|year|years)\s+(ago|from\s+now)$/i)
      return nil unless match

      count = match[1].to_i
      unit = match[2].downcase
      direction = match[3].downcase

      unit_type = UNITS[unit]
      offset = direction == "ago" ? -count : count

      case unit_type
      when :days
        @reference_date + offset
      when :weeks
        @reference_date + (offset * 7)
      when :months
        @reference_date >> offset
      when :years
        @reference_date >> (offset * 12)
      end
    end

    # Matches simple patterns like "tomorrow", "yesterday", "today"
    def parse_simple_relative
      case @input
      when "today"
        @reference_date
      when "tomorrow"
        @reference_date + 1
      when "yesterday"
        @reference_date - 1
      else
        nil
      end
    end

    # Matches "today", "tomorrow", "yesterday"
    def parse_today_tomorrow_yesterday
      parse_simple_relative
    end
  end
end
