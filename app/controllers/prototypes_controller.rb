class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit]

  def index
    @prototypes = Prototype.all.page(params[:page]).per(5)
    @prototypes_newest = Prototype.order('created_at DESC')
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    3.times {
      @prototype.tags.build
    }
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      # redirect_to ({ action: new }), alert: 'New prototype was unsuccessfully created'
      redirect_to root_path, alert: 'New prototype was unsuccessfully created'
     end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy if prototype.user_id == current_user.id
  end

  def edit
    @main_capture = @prototype.captured_images.where(status: 0)
    @sub_captures = @prototype.captured_images.where(status: 1)
      if CapturedImage.group(:prototype_id).count.select{|k,v| v <= 3}.keys.to_s.include?(params[:id])
        id = params[:id].to_i
        now_pic = CapturedImage.group(:prototype_id).count.select{|k,v| v <= 3}[id]
        @new_boxes = []
        while now_pic < 4 do
          new_box = Prototype.new(id: params[:id])
          new_box.captured_images.build
          @new_boxes << new_box
          now_pic += 1
        end
        return @new_boxes
      end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(update_params)
      redirect_to :root, notice: '更新されました'
    else
      redirect_to ({ action: edit }), alert: '正常に更新されませんでした'
    end
  end


  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status],
      tags_attributes: [:text]
    )
  end

  def update_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :_destroy, :id],
      tags_attributes: [:text, :id, :_destroy]
    )
  end
end
