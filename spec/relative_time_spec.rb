# frozen_string_literal: true

require "spec_helper"

RSpec.describe RelativeTime do
  it "has a version number" do
    expect(RelativeTime::VERSION).not_to be nil
  end

  describe ".parse" do
    let(:reference_date) { Date.new(2024, 1, 15) } # Monday, January 15, 2024

    context "with weekday patterns" do
      it "parses '2 Mondays ago'" do
        result = RelativeTime.parse("2 Mondays ago", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 1)) # January 1, 2024
      end

      it "parses '3 Fridays from now'" do
        result = RelativeTime.parse("3 Fridays from now", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 2, 2)) # February 2, 2024
      end

      it "parses '1 Sunday ago'" do
        result = RelativeTime.parse("1 Sunday ago", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 14)) # January 14, 2024
      end

      it "handles singular form 'Monday'" do
        result = RelativeTime.parse("1 Monday ago", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 8)) # January 8, 2024
      end
    end

    context "with next/last weekday patterns" do
      it "parses 'next Friday'" do
        result = RelativeTime.parse("next Friday", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 19)) # January 19, 2024
      end

      it "parses 'last Friday'" do
        result = RelativeTime.parse("last Friday", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 12)) # January 12, 2024
      end

      it "parses 'next Monday'" do
        result = RelativeTime.parse("next Monday", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 22)) # January 22, 2024
      end

      it "parses 'last Sunday'" do
        result = RelativeTime.parse("last Sunday", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 14)) # January 14, 2024
      end
    end

    context "with unit-based patterns" do
      it "parses '3 days ago'" do
        result = RelativeTime.parse("3 days ago", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 12))
      end

      it "parses '2 weeks from now'" do
        result = RelativeTime.parse("2 weeks from now", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 29))
      end

      it "parses '1 month ago'" do
        result = RelativeTime.parse("1 month ago", reference_date: reference_date)
        expect(result).to eq(Date.new(2023, 12, 15))
      end

      it "parses '2 months from now'" do
        result = RelativeTime.parse("2 months from now", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 3, 15))
      end

      it "parses '1 year ago'" do
        result = RelativeTime.parse("1 year ago", reference_date: reference_date)
        expect(result).to eq(Date.new(2023, 1, 15))
      end

      it "parses '2 years from now'" do
        result = RelativeTime.parse("2 years from now", reference_date: reference_date)
        expect(result).to eq(Date.new(2026, 1, 15))
      end
    end

    context "with simple relative patterns" do
      it "parses 'today'" do
        result = RelativeTime.parse("today", reference_date: reference_date)
        expect(result).to eq(reference_date)
      end

      it "parses 'tomorrow'" do
        result = RelativeTime.parse("tomorrow", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 16))
      end

      it "parses 'yesterday'" do
        result = RelativeTime.parse("yesterday", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 14))
      end
    end

    context "with invalid input" do
      it "returns nil for unparseable input" do
        result = RelativeTime.parse("invalid input", reference_date: reference_date)
        expect(result).to be_nil
      end

      it "returns nil for empty string" do
        result = RelativeTime.parse("", reference_date: reference_date)
        expect(result).to be_nil
      end
    end

    context "with case insensitivity" do
      it "parses uppercase input" do
        result = RelativeTime.parse("2 MONDAYS AGO", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 1))
      end

      it "parses mixed case input" do
        result = RelativeTime.parse("NexT FriDay", reference_date: reference_date)
        expect(result).to eq(Date.new(2024, 1, 19))
      end
    end
  end

  describe ".parse!" do
    let(:reference_date) { Date.new(2024, 1, 15) }

    it "returns a date for valid input" do
      result = RelativeTime.parse!("tomorrow", reference_date: reference_date)
      expect(result).to eq(Date.new(2024, 1, 16))
    end

    it "raises an error for invalid input" do
      expect {
        RelativeTime.parse!("invalid input", reference_date: reference_date)
      }.to raise_error(RelativeTime::Error, "Unable to parse 'invalid input'")
    end
  end
end
