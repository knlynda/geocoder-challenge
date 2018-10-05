require 'rails_helper'

RSpec.describe JsonWebToken do
  before do
    Timecop.freeze
    described_class.configure(
      secret_key_base: secret_key_base,
      token_live_time: token_live_time
    )
  end

  let(:secret_key_base) { 'base' }
  let(:token_live_time) { 1.minute }

  describe '.configure' do
    it 'assigns secret_key_base and token_live_time' do
      described_class.configure(
        secret_key_base: 'key_base',
        token_live_time: 1.hour
      )

      expect(described_class.secret_key_base).to eq('key_base')
      expect(described_class.token_live_time).to eq(1.hour)
    end
  end

  describe '.encode' do
    it 'encodes payload' do
      expect(JWT).to receive(:encode)
        .with({ user_id: 1, exp: token_live_time.from_now.to_i }, secret_key_base)

      described_class.encode(user_id: 1)
    end

    it 'does not encode payload in case of encode error' do
      allow(JWT).to receive(:encode)
        .with({ user_id: 1, exp: token_live_time.from_now.to_i }, secret_key_base)
        .and_raise(JWT::EncodeError)

      expect(described_class.encode(user_id: 1)).to be_nil
    end
  end

  describe '.decode' do
    it 'decodes payload' do
      expect(JWT).to receive(:decode)
        .with('token', secret_key_base) { double(first: []) }

      described_class.decode('token')
    end

    it 'does not decode payload in case of decode error' do
      allow(JWT).to receive(:decode)
        .with('token', secret_key_base).and_raise(JWT::DecodeError)

      expect(described_class.decode('token')).to eq({})
    end
  end

  it 'encodes and decodes payload' do
    token = described_class.encode(user_id: 100_500)
    expect(described_class.decode(token)[:user_id]).to eq(100_500)
  end
end
