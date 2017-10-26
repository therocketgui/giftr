class FriendsController < ApplicationController

  authorize_resource :class => false
  skip_authorize_resource :only => :view
  skip_authorize_resource :only => :share
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to '/register', :alert => exception.message }
    end
  end

  def index
  	friends = Friend.where(user_id: current_user.id)
  	@friend = Friend.new

    friends.each do |f|
       f.class.module_eval { attr_accessor :share}
    end

    @friends_all = friends
    # Get Shared Boards
    sharefriends = ShareFriend.where(user_shared_with_id: current_user.id)
    sharefriends.each do |f|
      f = Friend.find(f.friend_id)
      f.class.module_eval { attr_accessor :share}
      f.share = 1
      (@friends_shared_with ||= []) << f
      @friends_all += @friends_shared_with
    end
    @i = 0
  end
  
  def show
  	@friend = Friend.find(params[:id])
    @like = Like.new
    @item = Item.new
    @items = Item.where(friend_id: params[:id])

    amazon = Amazon.new
    @products = []

    asins = []
    # if item added to wishlist take asin
    @friend.items.each do |fitems|
      (asins ||= []) << fitems.asin
    end

    @friend.likes.each do |like|
      products = []
      # Reduce number of Amazon request
      if like.temp_items.any?
      # if Like's items exist in temp_item db call them
        temp_items = TempItem.where(like_id: like.id)
        temp_items.each do |item|
          # remove items from wishlist
          unless asins.include?(item.asin)
            product = Product.new
            product.asin = item.asin
            product.title = item.title
            product.author = item.author
            product.price = item.price
            product.image = item.image
            product.salesrank = item.salesrank
            product.url = item.url
            (products ||= []) << product
          end
        end
      else
        # if new Like's items, call Amazon API and create temp_item for each product
        products = amazon.format_hash(like.title)
        products.each do |product|
            TempItem.create asin: product.asin, title: product.title, author: product.author, price: product.price, image: product.image, salesrank: product.salesrank, url: product.url, like_id: like.id
        end
      end
      @products += products
    end

    # if user click, retrieve reviews and specific item through asin
    if params[:asin]
      @iframe = amazon.reviews_iframe(params[:asin])
      @item_infos = TempItem.where(asin: params[:asin])
    end
  end

  def wish
    @friend = Friend.find(params[:id])
    @items = Item.where(friend_id: @friend.id)
    @item = Item.new
    @comment = Comment.new
    @love = Love.new

    amazon = Amazon.new
    # if user click, retrieve reviews and specific item through asin
    if params[:item_id]
      @param_item = Item.find(params[:item_id])

      @iframe = amazon.reviews_iframe(@param_item.asin)
      @item_infos = Item.where(id: params[:item_id])
      @comments = Comment.where(item_id: params[:item_id])
      @loves = Love.where(item_id: params[:item_id])
    end
  end

  def view
    @friend = Friend.find_by(token_view: params[:token_view])
    @items = Item.where(friend_id: @friend.id)
  end

  def share
    if current_user
      redirect_to "/share/add/#{params[:token_share]}"
    else
      @friend = Friend.find_by(token_share: params[:token_share])
      @items = Item.where(friend_id: @friend.id)
      # store in session to redirect after registration
      session[:redirect_url] = "/share/add/#{params[:token_share]}"
    end     
  end

  def create
  	Friend.create(friend_params)
  	redirect_to "/friends"
  end

  def update
  	@friend = Friend.find(params[:friend][:id])
  	@friend.update(friend_params)
  	redirect_to "/friends"
  end

  def destroy
  	Friend.destroy(params[:friend][:id])
  	redirect_to "/friends"
  end

  private

  def friend_params
  	params.require(:friend).permit(:name, :birthday, :like, :user_id)
  end
end