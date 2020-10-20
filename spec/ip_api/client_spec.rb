RSpec.describe IpApi::Client do
  it "should include HTTParty module" do
    expect(IpApi::Client.ancestors).to include(HTTParty)
  end

  context "#build_query" do
    let(:client) { described_class.new }

    it "should convert fields to numeric value" do
      expect(client).to receive(:numeric_fields).and_call_original

      query = client.send(:build_query, fields: ['country', 'region'])

      expect(query).to eq(fields: 5)
    end

    it "should include language settings if provided" do
      query = client.send(:build_query, lang: 'es')

      expect(query).to eq(lang: 'es')
    end

    it "should not include fields numeric value if fields are emtpy" do
      query = client.send(:build_query, fields: [])
      expect(query.keys).not_to include(:fields)
    end

    it "should raise error on invalid options" do
      expect { client.send(:build_query, foo: 'bar') }
        .to raise_error(ArgumentError, /unknown keyword: :?foo/)
    end
  end

  context "fetch" do
    let(:client) { described_class.new }

    it "should call build_query with provided options" do
      stub_request(:get, 'http://ip-api.com/json/1.1.1.1').with(query: { foo: 'BAR' })

      expect(client).to receive(:build_query).with(foo: :bar).and_return(foo: 'BAR')

      client.fetch('1.1.1.1', foo: :bar)
    end

    it "should call #batch method if multiple addresses provided" do
      expect(client).to receive(:batch).with([1, 2], foo: :bar)
      client.fetch([1,2], foo: :bar)
    end
  end

  context "batch" do
    let(:client) { described_class.new }
    let(:ips) { ['1.1.1.1', '2.2.2.2'] }
    let(:query) { { foo: 'BAR' } }

    it "should call build_query with provided options" do
      stub_request(:post, 'http://ip-api.com/batch').with(query: query, body: ips.to_json)

      expect(client).to receive(:build_query).with(foo: :bar).and_return(query)

      client.batch(ips, foo: :bar)
    end
  end
end
