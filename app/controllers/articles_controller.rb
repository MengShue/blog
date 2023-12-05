class ArticlesController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  # before_action :set_listing, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.limit(20)
    # Article.paginate(:page => params[:page], per_page: 5).order('created_at DESC')
    # @articles = Article.where(user: current_user.id).limit(20)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user.id

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

    logger.info "article #{@article.id} written by #{@article.user} updated by user #{current_user.id}"

    return head :forbidden unless @article.user.to_i == current_user.id

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    return head :forbidden unless @article.user.to_i == current_user.id
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
