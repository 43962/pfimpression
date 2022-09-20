class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :set_search
  before_action :ensure_correct_customer, only: [:edit, :update]

  def index
   # 検索結果
   @search = Review.where(is_draft: false).ransack(params[:q])
   review = @search.result(distinct: true)
   review = if params[:category_id]
              review.where(category_id: params[:category_id])
            else
              review
            end
   @review = review.page(params[:page]).per(6)
  end

  def draft_index
    #下書き一覧
    @review = current_customer.reviews.where(is_draft: true)
    @review = @review.page(params[:page]).per(2)
  end

  def set_search
    # 検索オブジェクト
     #公開されてるレビューのみ表示
    @search = Review.ransack(params[:q])
  end

  def update
     @review = Review.find(params[:id])
    # ①下書きの更新（公開）の場合
    if params[:publicize_draft]
      # 公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      @review.attributes = review_params.merge(is_draft: false)
        if @review.save(context: :publicize)
          redirect_to review_path(@review.id), notice: "下書きを公開しました！"
        else
          @review.is_draft = true
          render :edit, alert: "レビューを公開できませんでした。入力内容をご確認のうえ再度お試しください"
        end
    # ②公開済みレビューの更新の場合
        elsif params[:update_review]
      @review.attributes = review_params
        if @review.save(context: :publicize)
          redirect_to review_path(@review.id), notice: "レビューを更新しました！"
        else
          render :edit, alert: "レビューを更新できませんでした。入力内容をご確認のうえ再度お試しください"
        end
    # ③下書きの更新（非公開）の場合
        else
        if @review.update(review_params)
          redirect_to review_path(@review.id), notice: "下書きを更新しました！"
        else
          render :edit, alert: "更新できませんでした。入力内容をご確認のうえ再度お試しください"
        end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to '/reviews'
  end

  def show
   @review = Review.find(params[:id])
   @comment = Comment.new
  end

  def new
    @review = Review.new
  end

  def create
        @review = Review.new(review_params)
        @review.customer_id = current_customer.id
        # 投稿ボタンを押下した場合
        if params[:post]
          if @review.save(context: :publicize)
            redirect_to reviews_path(@review.id), notice: "レビューを投稿しました！"
          else
            render :new, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
          end
        # 下書きボタンを押下した場合
        else
          if @review.update(is_draft: true)
            redirect_to customer_path(current_customer), notice: "レビューを下書き保存しました！"
          else
            render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
          end
        end
  end

  def edit
     @review = Review.find(params[:id])
  end




  private

  def review_params
    params.require(:review).permit(:height, :weight, :review, :item_name, :image, :category_id)
  end

  def ensure_correct_customer
      @review = Review.find(params[:id])
      @customer = @review.customer
    unless @customer == current_customer
      redirect_to reviews_path, notice: "他のユーザーの投稿編集画面へは遷移できません。"
    end
  end

end
