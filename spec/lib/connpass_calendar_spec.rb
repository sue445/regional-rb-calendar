RSpec.describe ConnpassCalendar do
  let(:calendar) { ConnpassCalendar.new }

  describe "#generate_ical" do
    subject { calendar.generate_ical(groups, current_date) }

    let(:groups) do
      [
        {
          "id" => "hirakatarb",
          "name" => "Hirakata.rb",
        },
        {
          "id" => "toyamarb",
          "name" => "Toyama.rb",
        },
      ]
    end

    let(:current_date) { Date.parse("2021-06-12") }

    let(:response_headers) { { "Content-Type" =>  "application/json" } }

    before do
      stub_request(:get, "https://connpass.com/api/v2/events/?count=100&start=1&subdomain=hirakatarb,toyamarb&ym=202103,202104,202105,202106,202107,202108,202109").
        to_return(status: 200, headers: response_headers, body: File.new("#{spec_dir}/fixtures/connpass_v2.json"))
    end

    let(:ical) do
      <<~ICAL
        BEGIN:VCALENDAR
        VERSION:2.0
        PRODID:icalendar-ruby
        CALSCALE:GREGORIAN
        METHOD:PUBLISH
        X-WR-CALNAME;VALUE=TEXT:connpassの地域.rb
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/206395/
        DTSTART:20210305T233000
        DTEND:20210306T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/206395/
        SUMMARY:Hirakata.rb #6
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/206846/
        DTSTART:20210312T233000
        DTEND:20210313T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/206846/
        SUMMARY:Hirakata.rb #7
        END:VEVENT
        BEGIN:VEVENT
        UID:https://toyamarb.connpass.com/event/204596/
        DTSTART:20210313T040000
        DTEND:20210313T090000
        DESCRIPTION:https://toyamarb.connpass.com/event/204596/
        SUMMARY:Toyama.rb #61 もくもく会オンライン
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/207932/
        DTSTART:20210319T233000
        DTEND:20210320T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/207932/
        SUMMARY:Hirakata.rb #8
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/208666/
        DTSTART:20210326T233000
        DTEND:20210327T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/208666/
        SUMMARY:Hirakata.rb #9
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/208815/
        DTSTART:20210402T233000
        DTEND:20210403T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/208815/
        SUMMARY:Hirakata.rb #10
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/209763/
        DTSTART:20210409T233000
        DTEND:20210410T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/209763/
        SUMMARY:Hirakata.rb #11
        END:VEVENT
        BEGIN:VEVENT
        UID:https://toyamarb.connpass.com/event/208320/
        DTSTART:20210410T040000
        DTEND:20210410T090000
        DESCRIPTION:https://toyamarb.connpass.com/event/208320/
        SUMMARY:Toyama.rb #62 もくもく会オンライン
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/210773/
        DTSTART:20210416T233000
        DTEND:20210417T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/210773/
        SUMMARY:Hirakata.rb #12
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/210917/
        DTSTART:20210423T233000
        DTEND:20210424T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/210917/
        SUMMARY:Hirakata.rb #13
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/212666/
        DTSTART:20210507T233000
        DTEND:20210508T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/212666/
        SUMMARY:Hirakata.rb #14
        END:VEVENT
        BEGIN:VEVENT
        UID:https://toyamarb.connpass.com/event/211449/
        DTSTART:20210508T040000
        DTEND:20210508T090000
        DESCRIPTION:https://toyamarb.connpass.com/event/211449/
        SUMMARY:Toyama.rb #63 もくもく会オンライン
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/213377/
        DTSTART:20210514T233000
        DTEND:20210515T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/213377/
        SUMMARY:Hirakata.rb #15
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/213559/
        DTSTART:20210521T233000
        DTEND:20210522T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/213559/
        SUMMARY:Hirakata.rb #16
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/214308/
        DTSTART:20210528T233000
        DTEND:20210529T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/214308/
        SUMMARY:Hirakata.rb #17
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/214841/
        DTSTART:20210604T233000
        DTEND:20210605T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/214841/
        SUMMARY:Hirakata.rb #18
        END:VEVENT
        BEGIN:VEVENT
        UID:https://hirakatarb.connpass.com/event/215595/
        DTSTART:20210611T233000
        DTEND:20210612T010000
        DESCRIPTION:https://hirakatarb.connpass.com/event/215595/
        SUMMARY:Hirakata.rb #19
        END:VEVENT
        BEGIN:VEVENT
        UID:https://toyamarb.connpass.com/event/213277/
        DTSTART:20210612T040000
        DTEND:20210612T090000
        DESCRIPTION:https://toyamarb.connpass.com/event/213277/
        SUMMARY:Toyama.rb #64 もくもく会オンライン
        END:VEVENT
        END:VCALENDAR
      ICAL
    end

    it { should eq ical.gsub("\n", "\r\n") }
  end

  describe ".connpass_terms" do
    subject { ConnpassCalendar.connpass_terms(current_date) }

    let(:current_date) { Date.parse("2021-06-12") }

    it { should eq [202103, 202104, 202105, 202106, 202107, 202108, 202109] }
  end
end
