class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    render plain: params[:article].inspect
    # create a new instant to save content
    @article = Article.new(article_params)
    @article.save
    # then redirect to a display page
    redirect_to articles_show(@article)
  end
  # this is a private function for passing parameters to create method
  private
    def article_params
      # it's a key value pair, key is the article, value is title and description
      params.require(:article).permit(:title, :description)
    end
end