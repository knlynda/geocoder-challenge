require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  describe '#call' do
    subject { described_class.new(headers).call }

    context 'when token present' do
      let(:headers) { { 'Authorization' => 'Authorization token' } }

      context 'when user exists' do
        let(:user) { create(:user) }

        it 'returns user' do
          expect(JsonWebToken).to receive(:decode)
            .with('token') { { user_id: user.id } }

          is_expected.to eq(user)
        end
      end

      context 'when user does not exist' do
        it 'returns nil' do
          expect(JsonWebToken).to receive(:decode)
            .with('token') { { user_id: 0 } }

          is_expected.to be_nil
        end
      end
    end

    context 'when token blank' do
      let(:headers) { {} }

      it { is_expected.to be_nil }
    end
  end
end
