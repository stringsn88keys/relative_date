# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-12-06

### Added
- Initial release
- Support for weekday patterns (e.g., "2 Mondays ago", "3 Fridays from now")
- Support for next/last weekday patterns (e.g., "next Monday", "last Friday")
- Support for unit-based relative dates (e.g., "3 days ago", "2 weeks from now")
- Support for simple relative dates (today, tomorrow, yesterday)
- Command-line interface (`relative_date` executable)
- Comprehensive test suite with RSpec
- Case-insensitive parsing
- Both `parse` and `parse!` methods
