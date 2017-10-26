class LikesController < ApplicationController
  def index

  end
  
  def show
  	@like = Like.find(params[:id])
  end

  def create
  	Like.create(like_params)
  	redirect_to "/friends/#{params[:like][:friend_id]}"
  end

  def update
  	@like = Like.find(params[:like][:id])
  	@like.update(like_params)
  	redirect_to "/friends"
  end

  def destroy
    like = Like.find(params[:like][:id])
    like.temp_items.destroy_all
  	Like.destroy(params[:like][:id])
  	redirect_to "/friends/#{params[:like][:friend_id]}"
  end

  private

  def like_params
  	params.require(:like).permit(:title, :friend_id)
  end
end
