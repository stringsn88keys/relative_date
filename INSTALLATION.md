# Installation Instructions

## Building the Gem

To build the gem from source:

```bash
gem build relative_time.gemspec
```

This will create a file like `relative_time-0.1.0.gem`.

## Installing Locally

To install the gem on your local machine:

```bash
gem install ./relative_time-0.1.0.gem
```

Or using rake:

```bash
bundle exec rake install
```

## Using in a Project

Add to your Gemfile:

```ruby
gem 'relative_time'
```

Then run:

```bash
bundle install
```

## Development Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Run tests:
   ```bash
   bundle exec rspec
   # or
   bundle exec rake
   ```
4. Try the CLI:
   ```bash
   ruby exe/relative_time "2 Mondays ago"
   ```

## Publishing to RubyGems (for maintainers)

1. Update version in `lib/relative_time/version.rb`
2. Update `CHANGELOG.md`
3. Commit changes
4. Run:
   ```bash
   bundle exec rake release
   ```

This will:
- Build the gem
- Create a git tag for the version
- Push the gem to RubyGems.org
- Push git commits and tags
