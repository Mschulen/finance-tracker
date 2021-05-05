class FriendsController < ApplicationController
  
  def show
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends_search = User.search(params[:friend])
      @friends_search = current_user.except_current_user(@friends_search)
      if @friends_search
        respond_to do |format|
          format.js { render partial: 'friends/result' }
        end
      else 
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid email"
          format.js { render partial: 'friends/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter an email to search"
        format.js { render partial: 'friends/result' }
      end
    end
  end

  def destroy
    friend = current_user.friendships.where(friend_id: params[:id]).first
    friend.destroy
    flash[:notice]="Unfollowed successfully."
  end

  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "User followed."
    else
      flash[:alert] = "Something went wrong."
    end
    redirect_to my_friends_path
  end
end