describe DoorkeeperCalendar do
  let(:calendar) { DoorkeeperCalendar.new }

  describe "#generate_ical" do
    subject { calendar.generate_ical(groups) }

    let(:groups) do
      [
        {
          "id" => "megurorb",
          "name" => "Meguro.rb",
        },
        {
          "id" => "gotanda-rb",
          "name" => "五反田.rb",
        },
      ]
    end

    before do
      ["megurorb", "gotanda-rb"].each do |group|
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
        UID:https://gotanda-rb.connpass.com/event/151288/
        DTSTART:20191031T103000
        DTEND:20191031T120000
        DESCRIPTION:https://gotanda-rb.connpass.com/event/151288/
        SUMMARY:gotanda.rb#39 ~ パフォーマンス改善 ~
        END:VEVENT
        BEGIN:VEVENT
        UID:https://gotanda-rb.connpass.com/event/155193/
        DTSTART:20191128T103000
        DTEND:20191128T120000
        DESCRIPTION:https://gotanda-rb.connpass.com/event/155193/
        SUMMARY:Gotanda.rb#40@giftee ~ Rubyしくじり失敗談 ~
        END:VEVENT
        BEGIN:VEVENT
        UID:https://gotanda-rb.connpass.com/event/162164/
        DTSTART:20200130T100000
        DTEND:20200130T120000
        DESCRIPTION:https://gotanda-rb.connpass.com/event/162164/
        SUMMARY:Gotanda.rb#41@MobileFactory ~ テーマフリー ~
        END:VEVENT
        BEGIN:VEVENT
        UID:https://megurorb.connpass.com/event/164225/
        DTSTART:20200131T103000
        DTEND:20200131T130000
        DESCRIPTION:https://megurorb.connpass.com/event/164225/
        SUMMARY:Meguro.rb#30 2020/1/31(Fri.) at ドリコム
        END:VEVENT
        BEGIN:VEVENT
        UID:https://megurorb.connpass.com/event/166498/
        DTSTART:20200227T103000
        DTEND:20200227T130000
        DESCRIPTION:https://megurorb.connpass.com/event/166498/
        SUMMARY:Meguro.rb#31 2020/2/27(Thu.) at giftee
        END:VEVENT
        END:VCALENDAR
      ICAL
    end

    it { should eq ical.gsub("\n", "\r\n") }
  end
end
