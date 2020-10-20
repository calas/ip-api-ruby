RSpec.describe IpApi do
  it "has a version number" do
    expect(IpApi::VERSION).not_to be nil
  end

  context "IpApi.info" do 
    it "passes it's arguments to a new Client instance's fetch method" do
      client = double(fetch: nil)

      expect(IpApi::Client).to receive(:new).and_return(client)
      expect(client).to receive(:fetch).with('foo', bar: :baz)

      IpApi.info('foo', bar: :baz)
    end
  end
end
