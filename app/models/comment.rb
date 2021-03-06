# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  has_many :replies, dependent: :destroy
  after_save :update_comments_counter

  validates :comment, presence: true
  validates :author, presence: true
  validates :avatar, presence: true

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
