class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
   @articles = Article.all
  end

  def show
    @article = Article.friendly.find(params[:slug]) # Использование ЧПУ для поиска статьи
  end

  def new
    @article = Article.new
  end

def create
  @article = Article.new(article_params)
  @article.slug = @article.title.parameterize 

  if @article.save
    redirect_to @article
  else
    render :new, status: :unprocessable_entity
  end
end

  def edit
  @article = Article.friendly.find(params[:slug])
  end


def update
  @article = Article.friendly.find(params[:slug]) 
  # Установка нового значения slug на только если title изменился
  if @article.title != article_params[:title]
    @article.slug = article_params[:title].parameterize
  end

  if @article.update(article_params)
    redirect_to article_path(@article) 
  else
    render :edit, status: :unprocessable_entity
  end
  end


  def destroy
    @article = Article.friendly.find(params[:slug]) 
    @article.comments.destroy_all 
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end

