describe EventCalendar do
  let(:calendar) { EventCalendar.new(site: site, title: title) }
  let(:site)     { "connpass" }
  let(:title)    { "connpassのイベント" }

  describe "#generate_ical_from_condo3" do
    subject { calendar.generate_ical_from_condo3(groups) }

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
        stub_request(:get, "https://condo3.appspot.com/api/connpass/#{group}.json").to_return(body: File.new("#{spec_dir}/fixtures/#{group}.json"))
      end
    end

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

  describe "#generate_ical_from_connpass" do
    subject { calendar.generate_ical_from_connpass(groups, current_date) }

    let(:groups) do
      [
        {
          "id" => "hirakatarb",
          "name" => "Hirakata.rb",
          "series_id" => 11126,
        },
        {
          "id" => "toyamarb",
          "name" => "Toyama.rb",
          "series_id" => 2557,
        },
      ]
    end

    let(:current_date) { Date.parse("2021-06-12") }

    before do
      stub_request(:get, "http://connpass.com/api/v1/event/?count=100&order=1&series_id=11126,2557&ym=202103,202104,202105,202106,202107,202108,202109").
        to_return(body: File.new("#{spec_dir}/fixtures/connpass.json"))
    end

    let(:ical) do
      <<~ICAL
        BEGIN:VCALENDAR
        VERSION:2.0
        PRODID:icalendar-ruby
        CALSCALE:GREGORIAN
        METHOD:PUBLISH
        X-WR-CALNAME;VALUE=TEXT:connpassのイベント
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
    subject { EventCalendar.connpass_terms(current_date) }

    let(:current_date) { Date.parse("2021-06-12") }

    it { should eq [202103, 202104, 202105, 202106, 202107, 202108, 202109] }
  end
end
