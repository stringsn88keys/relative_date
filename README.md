# RelativeDate

A Ruby gem for parsing natural language relative date expressions like "2 Mondays ago", "next Friday", "3 weeks from now", and more.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'relative_date'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install relative_date

## Usage

### Ruby API

```ruby
require 'relative_date'

# Parse a relative date expression
date = RelativeDate.parse("2 Mondays ago")
#=> #<Date: 2025-11-24>

# Use a custom reference date (defaults to today)
date = RelativeDate.parse("next Friday", reference_date: Date.new(2024, 1, 15))
#=> #<Date: 2024-01-19>

# Use parse! to raise an error on invalid input
date = RelativeDate.parse!("tomorrow")
#=> #<Date: 2025-12-07>

RelativeDate.parse!("invalid input")
#=> RelativeDate::Error: Unable to parse 'invalid input'
```

### Command Line

The gem includes a CLI tool:

```bash
$ relative_date "2 Mondays ago"
2025-11-24

$ relative_date "next Friday"
2025-12-12

$ relative_date "3 weeks from now"
2025-12-27

$ relative_date "tomorrow"
2025-12-07
```

## Supported Patterns

### Weekday Patterns

- `N <weekday>s ago` - e.g., "2 Mondays ago", "3 Fridays ago"
- `N <weekday>s from now` - e.g., "2 Tuesdays from now", "4 Wednesdays from now"
- `N <weekday> ago` - e.g., "1 Monday ago" (singular form also works)

### Next/Last Weekday

- `next <weekday>` - e.g., "next Monday", "next Friday"
- `last <weekday>` - e.g., "last Monday", "last Friday"

### Unit-Based Relative Dates

- `N days ago` / `N days from now` - e.g., "5 days ago", "3 days from now"
- `N weeks ago` / `N weeks from now` - e.g., "2 weeks ago", "1 week from now"
- `N months ago` / `N months from now` - e.g., "3 months ago", "6 months from now"
- `N years ago` / `N years from now` - e.g., "1 year ago", "2 years from now"

### Simple Relative Dates

- `today`
- `tomorrow`
- `yesterday`

## Features

- Case insensitive parsing (e.g., "NEXT FRIDAY", "Next Friday", "next friday" all work)
- Handles both singular and plural forms (e.g., "1 day ago" and "2 days ago")
- Returns `Date` objects for easy manipulation
- Includes both `parse` (returns nil on failure) and `parse!` (raises error on failure) methods
- No external dependencies beyond Ruby's standard library

## Examples

```ruby
# Today is Friday, December 6, 2025

RelativeDate.parse("2 Mondays ago")
#=> #<Date: 2025-11-24> (Monday, November 24, 2025)

RelativeDate.parse("next Friday")
#=> #<Date: 2025-12-12> (Friday, December 12, 2025)

RelativeDate.parse("last Sunday")
#=> #<Date: 2025-11-30> (Sunday, November 30, 2025)

RelativeDate.parse("3 weeks from now")
#=> #<Date: 2025-12-27> (Saturday, December 27, 2025)

RelativeDate.parse("5 days ago")
#=> #<Date: 2025-12-01> (Monday, December 1, 2025)

RelativeDate.parse("2 months ago")
#=> #<Date: 2025-10-06> (Monday, October 6, 2025)

RelativeDate.parse("tomorrow")
#=> #<Date: 2025-12-07> (Saturday, December 7, 2025)

# With a custom reference date
RelativeDate.parse("2 Mondays ago", reference_date: Date.new(2024, 1, 15))
#=> #<Date: 2024-01-01> (Monday, January 1, 2024)
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rspec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stringsn88keys/relative_date.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
