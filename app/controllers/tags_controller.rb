class TagsController < ApplicationController

  def index
    @tags = Tag.order("created_at DESC")
  end

  def show
    @tag = Tag.find(params[:id])
    @prototypes = @tag.prototypes
  end

end
