class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show update destroy ]
  

  # GET /comments
  def index
    @comments = Comment.all

    render json: CommentSerializer.new(@comments).serializable_hash.to_json
  end

  # GET /comments/1
  def show
    comment = Comment.find(params[:id])
    render json: CommentSerializer.new(comment).serializable_hash.to_json
  end

  # POST /comments
  def create
    @comment = recipe.comments.new(comment_params)
    @comment.user_id = params[:user_id]

        if @comment.save
          render json: serializer(@comment)
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def recipe
      @recipe ||= Recipe.find(params[:recipe_id])

    end
          # fast_jsonapi serializer
          def serializer(records, options = {})
          CommentSerializer
            .new(records, options)
            .serializable_hash.to_json
        end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :recipe_id)
    end
end