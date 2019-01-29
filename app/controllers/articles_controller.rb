class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # index action
  def index
    # get all articles
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  # new an article
  def new
    @article = Article.new
  end

  # create article
  def create

    # debugger

    # render plain: params[:article].inspect
    # create a new instant to save content
    @article = Article.new(article_params)

    @article.user = current_user
    # after save
    if @article.save
      # display it on the layouts application page, means for all pages
      flash[:success] = "Article was successfully created"
      # then redirect to a display page
      redirect_to article_path(@article)
    else
      # stay at the same page, and empty the text boxes => reload the page
      render 'new'
    end
  end

  # display article according to id
  def show
    @article = Article.find(params[:id])
  end

  # udate the content after eidt
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  # edit article according to id
  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = "Article was successfully deleted"
    redirect_to articles_path
  end

  # this is a private function for passing parameters to create method
  private
  # extract redundant article.find
  def set_article
    @article = Article.find(params[:id])
  end
  # Remember where you put private keyword. all the methods below that, will become private
  def article_params
    # it's a key value pair, key is the article, value is title and description
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can only edit or delete your article!"
      redirect_to root_path
    end
  end

end