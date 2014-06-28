class FavoritesController < ApplicationController

  def create
    authorize favorite
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

      if favorite.save
        flash[:notice] = "Favorited Post"
        redirect_to [@topic, @post]
      else
        flash[:error] = "Unable to add favorite"
        redirect_to [@topic, @post]
      end
  end

  def destroy
    authorize favorite
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

      if favorite.destroy
        flash[:notice] = "Removed favorite."
        redirect_to [@topic, @post]
      else
        flash[:error] = "Unable to remove favorite. Please try again."
        redirect_to [@topic, @post]
      end
  end
end