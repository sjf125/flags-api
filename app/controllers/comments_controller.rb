class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  # before_action :set_flag, only: [:index, :create]
  # before_action :set_user, only: [:index, :create]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    render json: @comment
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

    head :no_content
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_flag
      @flag = Flag.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :flag_id)
    end
end
