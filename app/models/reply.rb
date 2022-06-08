class Reply < ApplicationRecord
  belongs_to :comment
  after_save :update_comments_counter

  validates :reply, presence: true
  validates :author, presence: true
  validates :avatar, presence: true

  private

  def update_comments_counter
    comment.post.increment!(:comments_counter)
  end
end