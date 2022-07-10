class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]

  # GET /articles
  def index
    @articles = Article.all

    render json: ArticleSerializer.new(@articles).serializable_hash
  end

  # GET /articles/1
  def show
    render json: ArticleSerializer.new(@article).serializable_hash
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: ArticleSerializer.new(@article).serializable_hash, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: ArticleSerializer.new(@article).serializable_hash
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :detail)
    end
end
