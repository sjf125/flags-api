require 'rails_helper'

RSpec.describe 'Comments API' do
  def comment_params
    {
      content: 'You won\'t believe what happens next...'
    }
  end

  def comments
    Comment.all
  end

  def comment
    Comment.first
  end

  def user_params
    {
      email: 'alice@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  def user
    User.first
  end

  before(:all) do
    User.create!(user_params)
    Comment.create!(comment_params)
  end

  after(:all) do
    Comment.delete_all
    User.delete_all
  end

  describe 'GET /comments' do
    it 'lists all comments' do
      get '/comments'

      expect(response).to be_success

      comments_response = JSON.parse(response.body)
      expect(comments_response.length).to eq(comments.count)
      expect(comments_response[0]['content']).to eq(comment.content)
    end
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

  context 'when authenticated' do
    def headers
      {
        'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
      }
    end

    describe 'POST /comments' do
      it 'creates an comment' do
        post '/comments', { comment: comment_params }, headers

        expect(response).to be_success

        comment_response = JSON.parse(response.body)
        expect(comment_response['id']).not_to be_nil
        expect(comment_response['content']).to eq(comment_params[:content])
      end
    end

    describe 'PATCH /comments/:id' do
      def comment_diff
        { content: 'Two Stupid Tricks' }
      end

      it 'updates an comment' do
        patch "/comments/#{comment.id}", { comment: comment_diff }, headers

        expect(response).to be_success

        comment_response = JSON.parse(response.body)
        expect(comment_response['id']).to eq(comment.id)
        expect(comment_response['content']).to eq(comment_diff[:content])
      end
    end

    describe 'DELETE /comments/:id' do
      it 'deletes an comment' do
        delete "/comments/#{comment.id}", nil, headers

        expect(response).to be_success
        expect(response.body).to be_empty
      end
    end
  end

  context 'when not authenticated' do
    def headers
      {
        'HTTP_AUTHORIZATION' => nil
      }
    end

    describe 'POST /comments' do
      it 'is not successful' do
        post '/comments', nil, headers

        expect(response).not_to be_success
      end
    end

    describe 'PATCH /comments/:id' do
      it 'is not successful' do
        patch "/comments/#{comment.id}", nil, headers

        expect(response).not_to be_success
      end
    end

    describe 'DELETE /comments/:id' do
      it 'is not successful' do
        delete "/comments/#{comment.id}", nil, headers

        expect(response).not_to be_success
      end
    end
  end
end
