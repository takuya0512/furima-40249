class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Article.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to '/'
  end

  private
  def item_params
    items.require(:item).permit(:name, :image)
  end

end
