RSpec.describe DoorkeeperCalendar do
  let(:calendar) { DoorkeeperCalendar.new }

  describe "#generate_ical" do
    subject { calendar.generate_ical(groups) }

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

    before do
      ["mitakarb", "ruby-tuesday"].each do |group|
        stub_request(:get, "https://condo3.appspot.com/api/doorkeeper/#{group}.json").to_return(body: File.new("#{spec_dir}/fixtures/#{group}.json"))
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
        UID:https://mitakarb.doorkeeper.jp/events/133415
        DTSTART:20220310T103000
        DTEND:20220310T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/133415
        SUMMARY:mitaka.rb 2022-03-10木
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/134643
        DTSTART:20220322T093000
        DTEND:20220322T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/134643
        SUMMARY:Ruby Tuesday 💋 #126
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/134969
        DTSTART:20220329T093000
        DTEND:20220329T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/134969
        SUMMARY:Ruby Tuesday 💋 #127
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/135571
        DTSTART:20220405T093000
        DTEND:20220405T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/135571
        SUMMARY:Ruby Tuesday 💋 #128
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/135593
        DTSTART:20220412T093000
        DTEND:20220412T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/135593
        SUMMARY:Ruby Tuesday 💋 #129
        END:VEVENT
        BEGIN:VEVENT
        UID:https://mitakarb.doorkeeper.jp/events/134466
        DTSTART:20220414T103000
        DTEND:20220414T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/134466
        SUMMARY:mitaka.rb 2022-04-14木
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/135907
        DTSTART:20220419T093000
        DTEND:20220419T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/135907
        SUMMARY:Ruby Tuesday 💋 #130
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/136199
        DTSTART:20220426T093000
        DTEND:20220426T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/136199
        SUMMARY:Ruby Tuesday 💋 #131
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/136698
        DTSTART:20220510T093000
        DTEND:20220510T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/136698
        SUMMARY:Ruby Tuesday 💋 #132
        END:VEVENT
        BEGIN:VEVENT
        UID:https://mitakarb.doorkeeper.jp/events/135970
        DTSTART:20220512T103000
        DTEND:20220512T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/135970
        SUMMARY:mitaka.rb 2022-05-12木
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/137061
        DTSTART:20220517T093000
        DTEND:20220517T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/137061
        SUMMARY:Ruby Tuesday 💋 #133
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/138008
        DTSTART:20220524T093000
        DTEND:20220524T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/138008
        SUMMARY:Ruby Tuesday 💋 #134
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/138009
        DTSTART:20220531T093000
        DTEND:20220531T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/138009
        SUMMARY:Ruby Tuesday 💋 #135
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/138167
        DTSTART:20220607T093000
        DTEND:20220607T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/138167
        SUMMARY:Ruby Tuesday 💋 #136
        END:VEVENT
        BEGIN:VEVENT
        UID:https://mitakarb.doorkeeper.jp/events/137101
        DTSTART:20220609T103000
        DTEND:20220609T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/137101
        SUMMARY:mitaka.rb 2022-06-09木
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/138454
        DTSTART:20220614T093000
        DTEND:20220614T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/138454
        SUMMARY:Ruby Tuesday 💋 #137
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/138672
        DTSTART:20220621T093000
        DTEND:20220621T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/138672
        SUMMARY:Ruby Tuesday 💋 #138
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/138929
        DTSTART:20220628T093000
        DTEND:20220628T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/138929
        SUMMARY:Ruby Tuesday 💋 #139
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/139466
        DTSTART:20220705T093000
        DTEND:20220705T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/139466
        SUMMARY:Ruby Tuesday 💋 #140
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/139725
        DTSTART:20220712T093000
        DTEND:20220712T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/139725
        SUMMARY:Ruby Tuesday 💋 #141
        END:VEVENT
        BEGIN:VEVENT
        UID:https://mitakarb.doorkeeper.jp/events/139891
        DTSTART:20220714T103000
        DTEND:20220714T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/139891
        SUMMARY:mitaka.rb 2022-07-14木
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/139977
        DTSTART:20220719T093000
        DTEND:20220719T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/139977
        SUMMARY:Ruby Tuesday 💋 #142
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/140744
        DTSTART:20220726T103000
        DTEND:20220726T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/140744
        SUMMARY:Ruby Tuesday 💋 #143
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/140786
        DTSTART:20220802T093000
        DTEND:20220802T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/140786
        SUMMARY:Ruby Tuesday 💋 #143
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/141118
        DTSTART:20220809T093000
        DTEND:20220809T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/141118
        SUMMARY:Ruby Tuesday 💋 #144
        END:VEVENT
        BEGIN:VEVENT
        UID:https://mitakarb.doorkeeper.jp/events/141295
        DTSTART:20220811T103000
        DTEND:20220811T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/141295
        SUMMARY:mitaka.rb 2022-08-11木
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/141381
        DTSTART:20220816T093000
        DTEND:20220816T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/141381
        SUMMARY:Ruby Tuesday 💋 #145
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/141585
        DTSTART:20220823T093000
        DTEND:20220823T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/141585
        SUMMARY:Ruby Tuesday 💋 #146
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/142048
        DTSTART:20220830T093000
        DTEND:20220830T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/142048
        SUMMARY:Ruby Tuesday 💋 #147
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/142613
        DTSTART:20220906T093000
        DTEND:20220906T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/142613
        SUMMARY:Ruby Tuesday 💋 #148
        END:VEVENT
        BEGIN:VEVENT
        UID:https://ruby-tuesday.doorkeeper.jp/events/142963
        DTSTART:20220913T093000
        DTEND:20220913T120000
        DESCRIPTION:https://ruby-tuesday.doorkeeper.jp/events/142963
        SUMMARY:Ruby Tuesday 💋 #149
        END:VEVENT
        BEGIN:VEVENT
        UID:https://mitakarb.doorkeeper.jp/events/142614
        DTSTART:20220915T103000
        DTEND:20220915T123000
        DESCRIPTION:https://mitakarb.doorkeeper.jp/events/142614
        SUMMARY:mitaka.rb 2022-09-15木
        END:VEVENT
        END:VCALENDAR
      ICAL
    end

    it { should eq ical.gsub("\n", "\r\n") }
  end
end
