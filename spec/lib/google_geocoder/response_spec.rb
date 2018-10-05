require 'rails_helper'

RSpec.describe GoogleGeocoder::Response do
  describe '.new' do
    [
      [nil, {}],
      ['', {}],
      ['abc', {}],
      ['{}', {}],
      ['{"results":[{}]}', { 'results' => [{}] }]
    ].each do |json, data|
      context "where json #{json.inspect}" do
        it { expect(described_class.new(json).data).to eq(data) }
      end
    end
  end

  describe '#location' do
    [
      [nil, {}],
      ['', {}],
      ['abc', {}],
      ['{}', {}],
      ['{"results":[]}', {}],
      [
        '{"results":[{"geometry":{"location":{"lat":1,"lng":2}}},{"geometry":{"location":{"lat":3,"lng":4}}}]}',
        { 'lat' => 1, 'lng' => 2 }
      ]
    ].each do |json, location|
      context "where json #{json.inspect}" do
        subject { described_class.new(json).location }
        it { is_expected.to eq(location) }
      end
    end
  end

  describe '#error_message' do
    [
      [nil, nil],
      ['', nil],
      ['{}', nil],
      ['abc', nil],
      ['{"results":[]}', nil],
      ['{"error_message":"ERROR","status":"OVER_DAILY_LIMIT"}', 'Daily query limit is over.'],
      ['{"error_message":"ERROR","status":"OVER_QUERY_LIMIT"}', 'Query limit is over.'],
      ['{"error_message":"ERROR","status":"REQUEST_DENIED"}', 'Request denied.'],
      ['{"error_message":"ERROR","status":"INVALID_REQUEST"}', 'Missing the address parameter.'],
      ['{"error_message":"ERROR","status":"UNKNOWN_ERROR"}', 'Unknown error.']
    ].each do |json, error_message|
      context "where json #{json.inspect}" do
        subject { described_class.new(json).error_message }
        it { is_expected.to eq(error_message) }
      end
    end
  end

  describe '#status' do
    [
      [nil, nil],
      ['', nil],
      ['{}', nil],
      ['abc', nil],
      ['{"results":[]}', nil],
      ['{"status": "OK"}', 'OK']
    ].each do |json, status|
      context "where json #{json.inspect}" do
        subject { described_class.new(json).status }
        it { is_expected.to eq(status) }
      end
    end
  end

  describe '#success?' do
    [
      [nil, true],
      ['', true],
      ['{}', true],
      ['abc', true],
      ['{"results":[]}', true],
      ['{"error_message":"ERROR"}', false]
    ].each do |json, success|
      context "where json #{json.inspect}" do
        subject { described_class.new(json).success? }
        it { is_expected.to eq(success) }
      end
    end
  end

  describe '#failure?' do
    [
      [nil, false],
      ['', false],
      ['{}', false],
      ['abc', false],
      ['{"results":[]}', false],
      ['{"error_message":"ERROR"}', true]
    ].each do |json, failure|
      context "where json #{json.inspect}" do
        subject { described_class.new(json).failure? }
        it { is_expected.to eq(failure) }
      end
    end
  end

  describe '#empty?' do
    [
      [nil, true],
      ['', true],
      ['{}', true],
      ['abc', true],
      ['{"results":[]}', true],
      ['{"results":[{}]}', false]
    ].each do |json, empty|
      context "where json #{json.inspect}" do
        subject { described_class.new(json).empty? }
        it { is_expected.to eq(empty) }
      end
    end
  end
end
