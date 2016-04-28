require 'rails_helper'

RSpec.describe 'Comments API' do
  def comment_params
    {
      content: 'This is linkbait.'
    }
  end

  def comments
    Comment.all
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

  describe 'GET /comments/:id' do
    it 'shows one comment' do
      get "/comments/#{comment.id}"

      expect(response).to be_success

      comment_response = JSON.parse(response.body)
      expect(comment_response['id']).to eq(comment.id)
      expect(comment_response['content']).to eq(comment.content)
    end
  end

  describe 'PATCH /comments/:id' do
    def comment_diff
      { content: 'First! ZOMGWTFBBQ' }
    end

    it 'updates an comment' do
      patch "/comments/#{comment.id}", comment: comment_diff, format: :json

      expect(response).to be_success

      comment_response = JSON.parse(response.body)
      expect(comment_response['id']).to eq(comment.id)
      expect(comment_response['content']).to eq(comment_diff[:content])
    end
  end

  describe 'DELETE /comments/:id' do
    it 'deletes an comment' do
      delete "/comments/#{comment.id}",
             comment: { id: comment.id },
             format: :json

      expect(response).to be_success
      expect(response.body).to be_empty
    end
  end
end
