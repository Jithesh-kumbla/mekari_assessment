require "rails_helper"

RSpec.describe User, :type => :model do
  context "invalid parametes" do
    let(:user_1) { FactoryBot.build(:user, first_name: 'test_user_1', email: 'testuser1@gmail.com', password: 'password') }
    let(:user_2) { FactoryBot.build(:user, first_name: 'test_user_2', email: 'testuser2@gmail.com', password: 'password') }
    it "should not save the record without first_name" do
      user_1.first_name =  nil
      expect(user_1).to_not be_valid
      expect(user_1.save).to eq(false)
    end

    it "should not save the record without password" do
      user_1.password =  nil
      expect(user_1).to_not be_valid
      expect(user_1.save).to eq(false)
    end

    it 'should not save for duplicate email ids' do
      user_1.save
      user_2.email = user_1.email
      expect(user_2).to_not be_valid
      expect(user_2.save).to eq(false)
    end
  end

  context 'with valid parametes' do
    let(:user_1) { FactoryBot.build(:user, first_name: 'test_user_1', email: 'testuser1@gmail.com', password: 'password') }

    it 'should save the record' do
      expect(user_1).to be_valid
      expect(user_1.save).to eq(true)
    end
  end
end
