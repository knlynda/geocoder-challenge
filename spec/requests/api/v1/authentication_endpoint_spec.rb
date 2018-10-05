require 'rails_helper'

RSpec.describe 'Authentication endpoint', type: :request do
  subject { response.body }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  before { post(api_v1_authenticate_url, params: params.to_json, headers: headers) }

  context 'when user exists' do
    let(:user) { create(:user) }
    let(:params) { { email: user.email, password: user.password } }

    it { is_expected.to have_json_type(String).at_path('auth_token') }

    context 'when password incorrect' do
      let(:params) { { email: user.email, password: "#{user.password}!" } }

      it { is_expected.to be_json_eql({ error: 'Invalid credentials.' }.to_json) }
    end
  end

  context 'when user does not exist' do
    subject { response.body }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    [
      { email: 'unexisting@user.email', password: 'test1234' },
      { email: '', password: '' },
      { email: nil, password: nil },
      { email: 'unexisting@user.email' },
      { password: 'test1234' },
      {}
    ].each do |params|
      context "when params #{params.inspect}" do
        let(:params) { params }

        it { is_expected.to be_json_eql({ error: 'Invalid credentials.' }.to_json) }
      end
    end
  end
end
