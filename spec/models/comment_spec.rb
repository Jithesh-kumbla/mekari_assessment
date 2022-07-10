require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "invalid parametes" do
    let(:user) { FactoryBot.build(:user, first_name: 'test_user_1', email: 'testuser1@gmail.com', password: 'password') }
    let(:post) { FactoryBot.build(:post, title: 'test post', body: 'test_body_post', user: user) }
    let(:comment) { FactoryBot.build(:comment, body: 'my new comment', user: user, post: post) }
    it "should not save the blank comment" do
      comment.body =  ''
      expect(comment).to_not be_valid
      expect(comment.save).to eq(false)
    end

    it "should not save the record without user" do
      comment.user =  nil
      expect(comment).to_not be_valid
      expect(comment.save).to eq(false)
    end

    it "should not save the record without post" do
      comment.post =  nil
      expect(comment).to_not be_valid
      expect(comment.save).to eq(false)
    end
  end

  context 'with valid parametes' do
    let(:user) { FactoryBot.build(:user, first_name: 'test_user_1', email: 'testuser1@gmail.com', password: 'password') }
    let(:post) { FactoryBot.build(:post, title: 'test post', body: 'test_body_post', user: user) }
    let(:comment) { FactoryBot.build(:comment, body: 'my new comment', user: user, post: post) }

    it 'should save the record' do
      expect(comment).to be_valid
      expect(comment.save).to eq(true)
    end
  end
end
