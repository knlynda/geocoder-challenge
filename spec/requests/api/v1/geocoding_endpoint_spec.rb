require 'rails_helper'

RSpec.describe 'Geocoding endpoint', type: :request do
  subject { response.body }
  let(:headers) { { 'Authorization' => token } }

  before do
    JsonWebToken.configure(secret_key_base: 'key_base', token_live_time: 1.hour)
    GoogleGeocoder.configure(api_key: 'api_key')
  end

  context 'when user is authenticated' do
    let(:token) { JsonWebToken.encode(user_id: create(:user).id) }
    let(:request_url) { 'https://maps.googleapis.com/maps/api/geocode/json?address=checkpoint%20charlie&key=api_key' }

    context 'when address valid' do
      let(:params) { { address: 'checkpoint charlie' } }

      before do
        stub_request(:get, request_url)
          .to_return(status: 200, body: '{"results":[{"geometry":{"location":{"lat":1,"lng":2}}}]}')
        get(api_v1_geocode_url(params), headers: headers)
      end

      it { is_expected.to be_json_eql({ lat: 1, lng: 2 }.to_json) }
    end

    context 'when invalid request' do
      let(:params) { { address: 'checkpoint charlie' } }

      [
        ['INVALID_REQUEST',  'Missing the address parameter.'],
        ['OVER_QUERY_LIMIT', 'Query limit is over.'],
        ['OVER_DAILY_LIMIT', 'Daily query limit is over.'],
        ['REQUEST_DENIED',   'Request denied.'],
        ['UNKNOWN_ERROR',    'Unknown error.']
      ].each do |status, error|
        context "when status #{status.inspect} and error #{error.inspect}" do
          before do
            stub_request(:get, request_url)
              .to_return(status: 200, body: { status: status, error_message: 'ERROR' }.to_json)

            get(api_v1_geocode_url(params), headers: headers)
          end

          it { is_expected.to be_json_eql({ error: error }.to_json) }
        end
      end
    end
  end

  context 'when user is not authenticated' do
    let(:token) { '123.123.123' }
    let(:params) { { address: 'checkpoint charlie' } }

    before { get(api_v1_geocode_url(params), headers: headers) }
    it { is_expected.to be_json_eql({ error: 'Not Authorized.' }.to_json) }
  end
end
