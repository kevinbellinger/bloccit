class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
  
    if @comment.save
      flash[:notice] = "created comment"
      redirect_to topic_post_path(@post.topic, @post)
    else
      flash[:error] = "comment did not save"
      render 'posts/show'
    end
  end

    def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "\"#{current_user}\" comment was deleted successfully."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error deleting the comment."
      render :show
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end

