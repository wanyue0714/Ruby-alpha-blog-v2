class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  # create article
  def create
    # render plain: params[:article].inspect
    # create a new instant to save content
    @article = Article.new(article_params)
    # after save
    if @article.save
      # display it on the layouts application page, means for all pages
      flash[:notice] = "Article was successfully created"
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

  # this is a private function for passing parameters to create method
  private
  # Remember where you put private keyword. all the methods below that, will become private
  def article_params
    # it's a key value pair, key is the article, value is title and description
    params.require(:article).permit(:title, :description)
  end


end