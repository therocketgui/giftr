class LovesController < ApplicationController
  def index

  end
  
  def show
  	@love = Love.find(params[:id])
  end

  def create
  	Love.create(love_params)

    redirect_to "/wish/#{params[:love][:friend_id]}/item/#{params[:love][:item_id]}"
  end

  def update
  	@love = Love.find(params[:like][:id])
  	@love.update(love_params)
  	redirect_to "/wish"
  end

  def destroy
    love = Love.find(params[:love][:id])
  	Love.destroy(params[:love][:id])
  	redirect_to "/wish/#{params[:love][:friend_id]}/item/#{params[:love][:item_id]}"
  end

  private

  def love_params
  	params.require(:love).permit(:asin, :user_id, :date, :friend_id, :item_id,)
  end
end
