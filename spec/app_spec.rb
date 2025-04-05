RSpec.describe App do
  describe "GET /" do
    subject { get "/" }

    it { should be_ok }
  end

  describe "GET /api/calendar/connpass.ics" do
    subject { get "/api/calendar/connpass.ics" }

    before do
      stub_request(:get, %r(^https://connpass\.com/api/v2/events/)).
        to_return(status: 200, headers: response_headers, body: {events: []}.to_json )
    end

    let(:response_headers) { { "Content-Type" =>  "application/json" } }

    it { should be_ok }
    its(:status) { should eq 200 }
    its(:body)   { should include "connpassの地域.rb" }
  end

  describe "GET /api/calendar/doorkeeper.ics" do
    subject { get "/api/calendar/doorkeeper.ics" }

    before do
      stub_request(:get, %r(^https://api\.doorkeeper\.jp/groups/.+/events)).
        to_return(status: 200, headers: response_headers, body: [].to_json )
    end

    let(:response_headers) { { "Content-Type" =>  "application/json" } }

    it { should be_ok }
    its(:status) { should eq 200 }
    its(:body)   { should include "Doorkeeperの地域.rb" }
  end
end
