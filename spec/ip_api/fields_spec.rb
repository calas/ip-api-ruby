# frozen_string_literal: true

require 'spec_helper'

RSpec.describe IpApi::Fields do
  let(:tester) { Class.new { include IpApi::Fields }.new }

  context '#field_to_numeric' do
    it 'should return an integer' do
      expect(tester.field_to_numeric('country')).to an_instance_of(Integer)
    end

    it 'should return 0 for unknown values' do
      expect(tester.field_to_numeric('foo')).to be 0
    end

    it 'should be case insentive' do
      expect(tester.field_to_numeric('CountRy')).to be 1
    end

    it 'should return correct values for each field' do
      expect(tester.field_to_numeric('region')).to be 4
    end
  end

  context '#numeric_fields' do
    it "should return the sum of the fields's numeric values" do
      expect(tester.numeric_fields('country', 'region')).to be 5
      expect(tester.numeric_fields('foo', 'country', 'region')).to be 5
      expect(tester.numeric_fields('status', 'message', 'country', 'region', 'proxy', 'hosting')).to be 16_957_445
    end
  end
end
