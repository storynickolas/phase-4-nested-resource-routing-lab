class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items

  end

  def items
    user = User.find_by(id: params[:user_id])
    if user
      items = user.items
      render json: items
    else
      render_not_found_response
    end
  end

  def item_show
    item = Item.find(params[:id])
    if params[:user_id] == item.user_id.to_s
      render json: item
    else
      render_not_found_response
    end
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  end

  private
  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def render_not_found_response
    render json: { error: "Not found" }, status: :not_found
  end



end
