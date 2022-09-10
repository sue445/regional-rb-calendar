describe App do
  describe "GET /" do
    subject { get "/" }

    it { should be_ok }
  end

  describe "GET /api/calendar/connpass.ics" do
    subject { get "/api/calendar/connpass.ics" }

    before do
      allow(Connpass).to receive(:event_search) { Hashie::Mash.new({ events: [] }) }
    end

    it { should be_ok }
    its(:status) { should eq 200 }
    its(:body)   { should include "connpassの地域.rb" }
  end

  describe "GET /api/calendar/doorkeeper.ics" do
    subject { get "/api/calendar/doorkeeper.ics" }

    before do
      stub_request(:get, %r(https://condo3.appspot.com/api/doorkeeper/.+\.json)).
        to_return(status: 200, body: { events: [] }.to_json )
    end

    it { should be_ok }
    its(:status) { should eq 200 }
    its(:body)   { should include "Doorkeeperの地域.rb" }
  end
end
