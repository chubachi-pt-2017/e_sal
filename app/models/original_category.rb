class OriginalCategory < ApplicationRecord
  has_many :tutorials
  belongs_to :main_category

  validates :name,
  presence: { message: "カテゴリ名(表示用)を入力してください。"},
  uniqueness: { message: "入力したカテゴリ名(表示用)は既に存在しています。"}

  validates :name_url,
  presence: { message: "カテゴリ英語名を入力してください。"},
  uniqueness: { message: "入力したカテゴリ英語名は既に存在しています。"},
  format: { with: /\A[0-9a-z-]+\z/, message: "半角の小文字/数字とハイフンのみが使用できます。" }

  validates :main_category_id,
  presence: { message: "メインカテゴリを選択してください。"}
  # scope :latest_updated_at_order, -> {
  #   order(updated_at: :desc)
  # }

  class << self
    def get_by_user_id(user_id)
      includes(:main_category)
      .where(user_id: user_id).order(id: :asc)
    end
  end
end
