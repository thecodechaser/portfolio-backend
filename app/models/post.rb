# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :h_one, presence: true
  validates :p_one, presence: true
  validates :h_two, presence: true
  validates :p_two, presence: true
  validates :h_three, presence: true
  validates :p_three, presence: true
  validates :conclusion, presence: true
  validates :photo_one, presence: true
  validates :photo_two, presence: true
end
