class CommentsController < ApplicationController
  def create
    @article = Article.friendly.find(params[:article_slug])
    @comment = @article.comments.create(comment_params)
  redirect_back(fallback_location: article_path(@article)) 
  end

  def destroy
    @article = Article.friendly.find(params[:article_slug])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: article_path(@article))
  end


  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end

