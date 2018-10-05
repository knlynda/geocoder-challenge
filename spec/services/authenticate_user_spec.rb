require 'rails_helper'

RSpec.describe AuthenticateUser do
  describe '#call' do
    subject { described_class.new(email, password).call }

    context 'when user exists' do
      let(:user) { create(:user) }
      let(:token) { double }
      let(:email) { user.email }
      let(:password) { user.password }

      it 'returns token' do
        expect(::JsonWebToken).to receive(:encode)
          .with(user_id: user.id) { token }

        is_expected.to eq(token)
      end

      context 'when password wrong' do
        let(:password) { "#{user.password}!" }

        it 'returns nil' do
          expect(::JsonWebToken).not_to receive(:encode)
          is_expected.to eq(nil)
        end
      end
    end

    context 'when user does not exist' do
      let(:email) { 'unexisting@user.email' }
      let(:password) { 'test1234' }

      it 'returns nil' do
        expect(::JsonWebToken).not_to receive(:encode)
        is_expected.to eq(nil)
      end
    end
  end
end
