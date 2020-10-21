# frozen_string_literal: true

RSpec.describe IpApi::Client do
  it 'should include HTTParty module' do
    expect(described_class.ancestors).to include(HTTParty)
  end

  context 'fetch' do
    let(:client) { described_class.new }

    it 'should call build_query with provided options' do
      stub_request(:get, 'http://ip-api.com/json/1.1.1.1').with(query: { foo: 'BAR' })

      expect(IpApi::QueryParams).to receive(:build).with(foo: :bar).and_return(foo: 'BAR')

      client.fetch('1.1.1.1', foo: :bar)
    end

    it 'should call #batch method if multiple addresses provided' do
      expect(client).to receive(:batch).with([1, 2], foo: :bar)
      client.fetch([1, 2], foo: :bar)
    end
  end

  context 'batch' do
    let(:client) { described_class.new }
    let(:ips) { ['1.1.1.1', '2.2.2.2'] }
    let(:query) { { foo: 'BAR' } }

    it 'should call build_query with provided options' do
      stub_request(:post, 'http://ip-api.com/batch').with(query: query, body: ips.to_json)

      expect(IpApi::QueryParams).to receive(:build).with(foo: :bar).and_return(query)

      client.batch(ips, foo: :bar)
    end
  end
end
