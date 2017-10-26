class TempItemsController < ApplicationController
  def index

  end
  
  def show
  	@item = Item.find(params[:id])
  end

  def create
  	Item.create(item_params)
  	redirect_to "/friends/#{params[:item][:friend_id]}"
    end
  end

  def update
  	@item = Item.find(params[:item][:id])
  	@item.update(item_params)
  	redirect_to "/friends"
  end

  def destroy
  	items = Item.where(friend_id: params[:item][:friend_id])
  	items.where(asin: params[:item][:asin]).destroy_all
  	redirect_to "/friends/#{params[:item][:friend_id]}"
    end
  end

  private

  def temp_item_params
  	params.require(:item).permit(:asin, :title, :author, :price, :image, :salesrank, :url, :like_id)
  end
end

end
