class Comment < ApplicationRecord
  belongs_to :post

  validates :comment, presence: true
  validates :author, presence: true
  validates :avatar, presence: true

  after_save :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end