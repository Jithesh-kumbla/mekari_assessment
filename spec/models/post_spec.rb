require "rails_helper"

RSpec.describe Post, :type => :model do
  context "invalid parametes" do
    let(:user) { FactoryBot.build(:user, first_name: 'test_user_1', email: 'testuser1@gmail.com', password: 'password') }
    let(:post) { FactoryBot.build(:post, title: 'test post', body: 'test_body_post', user: user) }
    it "should not save the record with less characters in title" do
      post.title =  't'
      expect(post).to_not be_valid
      expect(post.save).to eq(false)
    end

    it "should not save the record without user" do
      post.user =  nil
      expect(post).to_not be_valid
      expect(post.save).to eq(false)
    end
  end

  context 'with valid parametes' do
    let(:user) { FactoryBot.build(:user, first_name: 'test_user_1', email: 'testuser1@gmail.com', password: 'password') }
    let(:post) { FactoryBot.build(:post, title: 'test post', body: 'test_body_post', user: user) }

    it 'should save the record' do
      expect(post).to be_valid
      expect(post.save).to eq(true)
    end
  end
end
