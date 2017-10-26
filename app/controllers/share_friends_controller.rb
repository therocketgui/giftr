class ShareFriendsController < ApplicationController
  def index

  end
  
  def show

  end

  def create

    if current_user
      user_sharing = Friend.find_by(token_share: params[:token_share])
      exists = ShareFriend.where('user_sharing_id = ? AND user_shared_with_id = ? AND friend_id = ?', user_sharing.user_id, current_user.id, user_sharing.id)

      if exists.empty?
        if user_sharing.user_id != current_user.id
    	     ShareFriend.create(user_sharing_id: user_sharing.user_id, user_shared_with_id: current_user.id, friend_id: user_sharing.id)
        end
      end

    end
    redirect_to "/friends"

  end

  def update

  end

  def destroy
  	items = ShareFriend.destroy(params[:id])
  	redirect_to "/friends"
  end

  private

  def share_friends_params
  	params.require(:share_friend).permit(:user_sharing_id, :user_shared_with_id, :friend_id)
  end

end
