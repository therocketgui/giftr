class CommentsController < ApplicationController

  def index

  end
  
  def show
  	@comment = Comment.find(params[:id])
  end

  def create
  	Comment.create(comment_params)

    redirect_to "/wish/#{params[:comment][:friend_id]}/item/#{params[:comment][:item_id]}"
  end

  def update
  	@comment = Comment.find(params[:like][:id])
  	@comment.update(comment_params)
  	redirect_to "/wish"
  end

  def destroy
    comment = Comment.find(params[:comment][:id])
  	Comment.destroy(params[:comment][:id])
  	redirect_to "/wish/#{params[:comment][:friend_id]}/item/#{params[:comment][:item_id]}"
  end

  private

  def comment_params
  	params.require(:comment).permit(:asin, :user_id, :date, :content, :friend_id, :item_id,)
  end

end
