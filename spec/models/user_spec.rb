require 'rails_helper'

describe User do

  it { should have_many :cards }

  it { should have_many :authentications }

  it { should accept_nested_attributes_for :authentications }

  it { should validate_confirmation_of :password }

  it { should validate_length_of(:password).is_at_least(3) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :email }

  it { should allow_value('user@example.com').for(:email) }

  describe 'create user' do

    it 'user create with  valid attributes' do
      user = User.create(email: '111@222.com', password: '1111', password_confirmation: '1111')
      expect(user).to be_valid
    end

    it 'user create with  invalid email' do
      user = User.create(email: '111222.com', password: '1111', password_confirmation: '1111')
      expect(user).to_not be_valid
    end

    it 'user create with  blank password' do
      user = User.create(email: '111222.com', password: '', password_confirmation: '1111')
      expect(user).to_not be_valid
    end

    it 'user create with  blank password_confirmation' do
      user = User.create(email: '111222.com', password: '1111', password_confirmation: '')
      expect(user).to_not be_valid
    end
  end

  describe 'update user' do

    before { @user = User.create(email: '111@222.com', password: '1111', password_confirmation: '1111') }

    it 'user update with  valid attributes' do
      user1 = @user.update(email: '211@222.com', password: '2111', password_confirmation: '2111')
      expect(user1).to be true
    end

    it 'user update with  invalid attributes' do
      user1 = @user.update(email: '211222.com', password: '2111', password_confirmation: '2111')
      expect(user1).to be false
    end
  end

  describe 'review notification' do
    let(:user) { create(:user, email: 'stavcd@mail.ru')}
    before do
      Timecop.return_to_baseline
      @card = user.cards.create(original_text: 'hello', translated_text: 'Привет',
                                review_date: (DateTime.current + 1.day))
    end
    it 'change deliveries count' do
      expect { user.review_notification }.
          to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

end
