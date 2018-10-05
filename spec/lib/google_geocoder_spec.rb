require 'rails_helper'

RSpec.describe GoogleGeocoder do
  describe '.configure' do
    it 'assigns api_key' do
      described_class.configure(api_key: 'test_api_key')
      expect(described_class.api_key).to eq('test_api_key')
    end
  end

  describe '.geocode' do
    before { described_class.configure(api_key: 'test_api_key') }

    context 'when address exists' do
      let(:address) { 'existing_address' }
      let(:uri) { URI('https://maps.googleapis.com/maps/api/geocode/json?address=existing_address&key=test_api_key') }
      let(:response_json) { double }

      it do
        expect(::Net::HTTP).to receive(:get)
          .with(uri) { response_json }.once

        expect(::GoogleGeocoder::Response).to receive(:new)
          .with(response_json).once

        described_class.geocode(address)
      end
    end

    context 'when address blank' do
      let(:address) { nil }
      let(:uri) { URI('https://maps.googleapis.com/maps/api/geocode/json?address&key=test_api_key') }
      let(:response_json) { double }

      it do
        expect(::Net::HTTP).to receive(:get)
          .with(uri) { response_json }.once

        expect(::GoogleGeocoder::Response).to receive(:new)
          .with(response_json).once

        described_class.geocode(address)
      end
    end
  end
end
