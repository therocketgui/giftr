class ItemsController < ApplicationController
  def index

  end
  
  def show
  	@item = Item.find(params[:id])
  end

  def create
  	Item.create(item_params)

    respond_to do |format|
      format.html { redirect_to "/friends/#{params[:item][:friend_id]}" }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  def create_modal
    Item.create(item_params)
    redirect_to "/friends/#{params[:item][:friend_id]}"
  end

  def update
  	@item = Item.find(params[:item][:id])
  	@item.update(item_params)
  	redirect_to "/friends"
  end

  def destroy
  	items = Item.where(friend_id: params[:item][:friend_id])
  	items.where(asin: params[:item][:asin]).destroy_all
  	#redirect_to "/friends/#{params[:item][:friend_id]}"

    respond_to do |format|
      format.html { redirect_to "/friends/#{params[:item][:friend_id]}" }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private

  def item_params
  	params.require(:item).permit(:asin, :title, :author, :price, :image, :salesrank, :url, :friend_id)
  end
end
