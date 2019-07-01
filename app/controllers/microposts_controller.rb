class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.paginate(page: params[:page], per_page: 15).order(created_at: :desc)
    @micropost = Micropost.new(params[:content])
  end

  def create
    micropost = current_user.microposts.create(content: params[:micropost][:content])
    if micropost.save
      flash[:success] = "WOw nIcE pOst!"
    else
      flash[:danger] = "pppfffff"
    end
    redirect_to action: :index
  end
end
