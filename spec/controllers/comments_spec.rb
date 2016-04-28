require 'rails_helper'

RSpec.describe CommentsController do
  def comment_params
    {
      content: 'This is linkbait.'
    }
  end

  def comment
    Comment.first
  end

  before(:all) do
    Comment.create!(comment_params)
  end

  after(:all) do
    Comment.delete_all
  end

  describe 'GET show' do
    before(:each) do
      get :show, id: comment.id
    end

    it 'is successful' do
      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      comment_response = JSON.parse(response.body)
      expect(comment_response).not_to be_nil
    end
  end

  describe 'PATCH update' do
    def comment_diff
      { content: 'First! ZOMGWTFBBQ' }
    end

    before(:each) do
      patch :update, id: comment.id, comment: comment_diff, format: :json
    end

    it 'is successful' do
      expect(response).to be_successful
    end

    it 'renders a JSON response' do
      comment_response = JSON.parse(response.body)
      expect(comment_response).not_to be_nil
    end
  end

  describe 'DELETE destroy' do
    it 'is successful and returns an empty response' do
      delete :destroy, id: comment.id, format: :json

      expect(response).to be_successful
      expect(response.body).to be_empty
    end
  end
end
