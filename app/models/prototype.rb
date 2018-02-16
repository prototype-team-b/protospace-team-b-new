class Prototype < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :tags, through: :prototype_tags
  has_many :prototype_tags, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  accepts_nested_attributes_for :tags, reject_if: :reject_tags, allow_destroy: true
  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images, allow_destroy: true

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  validate :require_any_tag

  def reject_sub_images(attributed)
    exists = attributed[:id].present?
    empty = attributed[:content].blank?
    attributed.merge!(_destroy: 1) if exists && empty
    !exists && empty
  end

  def reject_tags(attributed)
    exists = attributed[:id].present?
    empty = attributed[:text].blank?
    attributed.merge!(_destroy: 1) if exists && empty
    !exists && empty
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def require_any_tag
    errors.add(:base, :no_tag) if tags.blank?
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end


end
