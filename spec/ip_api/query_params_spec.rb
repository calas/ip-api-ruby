# frozen_string_literal: true

RSpec.describe IpApi::QueryParams do
  it 'should include Fields module' do
    expect(described_class.ancestors).to include(IpApi::Fields)
  end

  context '#build' do
    it 'should convert fields to numeric value' do
      query = described_class.new(fields: %w[country region])

      expect(query).to receive(:numeric_fields).and_call_original
      expect(query.build).to eq(fields: 5)
    end

    it 'should include language settings if provided' do
      query = described_class.new(lang: 'es')

      expect(query.build).to eq(lang: 'es')
    end

    it 'should not include fields numeric value if fields are emtpy' do
      query = described_class.new(fields: [])
      expect(query.build.keys).not_to include(:fields)
    end

    it 'should raise error on invalid options' do
      expect { described_class.new(foo: 'bar') }
        .to raise_error(ArgumentError, /unknown keyword: :?foo/)
    end
  end
end
