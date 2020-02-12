describe App do
  describe "GET /" do
    subject { get "/" }

    it { should be_ok }
  end

  describe "GET /api/calendar/connpass.ics" do
    subject { get "/api/calendar/connpass.ics" }

    before do
      ["megurorb", "gotanda-rb"].each do |group|
        stub_request(:get, "https://condo3.appspot.com/api/connpass/#{group}.json").to_return(body: File.new("#{spec_dir}/fixtures/#{group}.json"))
      end
    end

    let(:ics) do
      <<~ICS
        BEGIN:VCALENDAR
        VERSION:2.0
        PRODID:icalendar-ruby
        CALSCALE:GREGORIAN
        METHOD:PUBLISH
        X-WR-CALNAME;VALUE=TEXT:connpassのイベント
        BEGIN:VEVENT
        UID:https://gotanda-rb.connpass.com/event/151288/
        DTSTART:20191031T193000
        DTEND:20191031T210000
        DESCRIPTION:https://gotanda-rb.connpass.com/event/151288/
        SUMMARY:gotanda.rb#39 ~ パフォーマンス改善 ~
        END:VEVENT
        BEGIN:VEVENT
        UID:https://gotanda-rb.connpass.com/event/155193/
        DTSTART:20191128T193000
        DTEND:20191128T210000
        DESCRIPTION:https://gotanda-rb.connpass.com/event/155193/
        SUMMARY:Gotanda.rb#40@giftee ~ Rubyしくじり失敗談 ~
        END:VEVENT
        BEGIN:VEVENT
        UID:https://gotanda-rb.connpass.com/event/162164/
        DTSTART:20200130T190000
        DTEND:20200130T210000
        DESCRIPTION:https://gotanda-rb.connpass.com/event/162164/
        SUMMARY:Gotanda.rb#41@MobileFactory ~ テーマフリー ~
        END:VEVENT
        BEGIN:VEVENT
        UID:https://megurorb.connpass.com/event/164225/
        DTSTART:20200131T193000
        DTEND:20200131T220000
        DESCRIPTION:https://megurorb.connpass.com/event/164225/
        SUMMARY:Meguro.rb#30 2020/1/31(Fri.) at ドリコム
        END:VEVENT
        BEGIN:VEVENT
        UID:https://megurorb.connpass.com/event/166498/
        DTSTART:20200227T193000
        DTEND:20200227T220000
        DESCRIPTION:https://megurorb.connpass.com/event/166498/
        SUMMARY:Meguro.rb#31 2020/2/27(Thu.) at giftee
        END:VEVENT
        END:VCALENDAR
      ICS
    end

    it { should be_ok }
    its(:status) { should eq 200 }
    its(:body) { should eq ics.gsub("\n", "\r\n") }
  end
end
