RSpec.describe "docs/config/" do
  %w(connpass doorkeeper).each do |site|
    describe "#{site}.json" do
      subject(:groups) { JSON.parse(json_path.read)["groups"] }

      let(:json_path) { config_dir.join("#{site}.json") }

      it "id shouldn't be duplicated" do
        ids = groups.map { |g| g["id"] }
        expect(ids).to match_array(ids.uniq)
      end

      it "name shouldn't be duplicated" do
        names = groups.map { |g| g["name"] }
        expect(names).to match_array(names.uniq)
      end
    end
  end
end
