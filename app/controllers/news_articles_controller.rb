class NewsArticlesController < ApplicationController
  before_action :set_news_article, only: [:show, :edit, :update, :destroy]

  # GET /news_articles
  # GET /news_articles.json
  def index
    @news_articles = NewsArticle.all
  end

  def paginate_news_articles
    @news_articles = NewsArticle.page(params[:page]).per(20)
    render json: @news_articles
  end

  # GET /news_articles/1
  # GET /news_articles/1.json
  def show
  end

  # GET /news_articles/new
  def new
    @news_article = NewsArticle.new
  end

  # GET /news_articles/1/edit
  def edit
  end

  # POST /news_articles
  # POST /news_articles.json
  def create
    @news_article = NewsArticle.new(news_article_params)

    respond_to do |format|
      if @news_article.save
        format.html { redirect_to @news_article, notice: 'News article was successfully created.' }
        format.json { render :show, status: :created, location: @news_article }
      else
        format.html { render :new }
        format.json { render json: @news_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_articles/1
  # PATCH/PUT /news_articles/1.json
  def update
    respond_to do |format|
      if @news_article.update(news_article_params)
        format.html { redirect_to @news_article, notice: 'News article was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_article }
      else
        format.html { render :edit }
        format.json { render json: @news_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_articles/1
  # DELETE /news_articles/1.json
  def destroy
    @news_article.destroy
    respond_to do |format|
      format.html { redirect_to news_articles_url, notice: 'News article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_article
      @news_article = NewsArticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_article_params
      params.require(:news_article).permit(:title, :posted_at, :posted_by, :article_text)
    end
end
