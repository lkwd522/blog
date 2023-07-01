class ArticlesController < ApplicationController
  before_action :authenticate_user!
<<<<<<< HEAD
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
=======
  
  def index
   @articles = Article.all
  end

  def show
    @article = Article.friendly.find(params[:slug]) # Использование ЧПУ для поиска статьи
>>>>>>> d11afff (Добавил ЧПУ)
  end

  def new
    @article = Article.new
  end

<<<<<<< HEAD
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
  @article = Article.find(params[:id])
  @article.comments.destroy_all # Удалить все связанные комментарии
  @article.destroy

  redirect_to root_path, status: :see_other
end


  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

=======
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
  @article = Article.friendly.find(params[:slug]) # Использование ЧПУ для поиска статьи

  # Установка нового значения slug на основе title только если title изменился
  if @article.title != article_params[:title]
    @article.slug = article_params[:title].parameterize
  end

  if @article.update(article_params)
    redirect_to @article
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
>>>>>>> d11afff (Добавил ЧПУ)
end

