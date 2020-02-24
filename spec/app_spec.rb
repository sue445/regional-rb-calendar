describe App do
  describe "GET /" do
    subject { get "/" }

    it { should be_ok }
  end

  describe "GET /api/calendar/:site.ics" do
    subject { get "/api/calendar/#{site}.ics" }

    let(:calendar) { EventCalendar.new(site: site, title: title) }

    let(:ical) do
      <<~ICAL
        BEGIN:VCALENDAR
        VERSION:2.0
        PRODID:icalendar-ruby
        CALSCALE:GREGORIAN
        METHOD:PUBLISH
        X-WR-CALNAME;VALUE=TEXT:connpassのイベント
        BEGIN:VEVENT
        UID:https://gotanda-rb.connpass.com/event/151288/
        DTSTART:20191031T103000
        DTEND:20191031T120000
        DESCRIPTION:https://gotanda-rb.connpass.com/event/151288/
        SUMMARY:gotanda.rb#39 ~ パフォーマンス改善 ~
        END:VEVENT
        END:VCALENDAR
      ICAL
    end

    before do
      allow(calendar).to receive(:generate_ical) { ical }
      allow(App).to(receive(:calendar).with(site, title)) { calendar }
    end

    context "When connpass" do
      let(:site)  { "connpass" }
      let(:title) { "connpassの地域.rb" }

      it { should be_ok }
      its(:status) { should eq 200 }
      its(:body)   { should eq ical }
    end

    context "When doorkeeper" do
      let(:site)  { "doorkeeper" }
      let(:title) { "Doorkeeperの地域.rb" }

      it { should be_ok }
      its(:status) { should eq 200 }
      its(:body)   { should eq ical }
    end
  end
end
