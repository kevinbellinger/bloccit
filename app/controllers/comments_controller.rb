class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "created comment"
      redirect_to topic_post_path(@topic, @post)
    else
      flash[:error] = "comment did not save"
      render 'posts/show'
    end
  end

    def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name

    authorize @topic
    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end

