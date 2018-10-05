require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(build(:user)).to be_valid }
  it { expect(create(:user)).to be_persisted }

  describe 'validations' do
    describe 'name' do
      context 'when blank' do
        subject { build(:user, name: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:name]).to eq(["can't be blank"])
        end
      end
    end

    describe 'email' do
      context 'when blank' do
        subject { build(:user, email: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:email]).to eq(["can't be blank"])
        end
      end

      context 'when wrong format' do
        subject { build(:user, email: 'wrongemail!') }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:email]).to eq(['is invalid'])
        end
      end

      context 'when not unique' do
        subject { build(:user, email: user.email) }
        let(:user) { create(:user) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:email]).to eq(['has already been taken'])
        end
      end
    end

    describe 'password' do
      context 'when blank' do
        subject { build(:user, password: nil) }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:password]).to eq(["can't be blank"])
        end
      end
    end

    describe 'password_confirmation' do
      context 'when blank' do
        subject { build(:user, password_confirmation: nil) }
        it { is_expected.to be_valid }
      end

      context 'when does not match with password' do
        subject { build(:user, password: '1234', password_confirmation: '5678') }
        it do
          is_expected.to be_invalid
          expect(subject.errors[:password_confirmation]).to eq(["doesn't match Password"])
        end
      end
    end
  end
end
