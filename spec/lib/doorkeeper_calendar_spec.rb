RSpec.describe DoorkeeperCalendar do
  let(:calendar) { DoorkeeperCalendar.new }

  describe "#generate_ical" do
    subject { calendar.generate_ical(groups, current_date) }

    let(:current_date) { Date.parse("2021-09-10") }

    let(:groups) do
      [
        {
          "id" => "mitakarb",
          "name" => "mitaka.rb",
        },
        {
          "id" => "ruby-tuesday",
          "name" => "Ruby Tuesday",
        },
      ]
    end

    let(:response_headers) { { "Content-Type" =>  "application/json" } }

    before do
      ["mitakarb", "ruby-tuesday"].each do |group|
        stub_request(:get, "https://api.doorkeeper.jp/groups/#{group}/events?since=2021-03-10&sort=published_at&until=2022-03-10").
          to_return(status: 200, headers: response_headers, body: File.new("#{spec_dir}/fixtures/doorkeeper_#{group}.json"))
      end
    end

    let(:ical) do
      <<~ICAL
        BEGIN:VCALENDAR
        VERSION:2.0
        PRODID:icalendar-ruby
        CALSCALE:GREGORIAN
        METHOD:PUBLISH
        X-WR-CALNAME;VALUE=TEXT:Doorkeeperの地域.rb
        BEGIN:VEVENT
        UID:https://mitakarb.doorkeeper.jp/events/132027
        DTSTART:20220210T103000
        DTEND:20220210T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/132027
        SUMMARY:mitaka.rb 2022-02-10木
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/134038
        DTSTART:20220308T093000
        DTEND:20220308T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/134038
        SUMMARY:Ruby Tuesday 💋 #124
        END:VEVENT
        END:VCALENDAR
      ICAL
    end

    it { should eq ical.gsub("\n", "\r\n") }
  end
end
