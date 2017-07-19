class OriginalCategory < ApplicationRecord
  has_many :tutorials
  belongs_to :main_category

  validates :name,
  presence: { message: "カテゴリ名(表示用)を入力してください。"},
  uniqueness: { message: "入力したカテゴリ名(表示用)は既に存在しています。"},
  length: { maximum: 30, message: "最大文字数は30文字です。" }

  validates :name_url,
  presence: { message: "カテゴリ英語名を入力してください。"},
  uniqueness: { message: "入力したカテゴリ英語名は既に存在しています。"},
  format: { with: /\A[0-9a-z-]+\z/, message: "半角の小文字/数字とハイフンのみが使用できます。" },
  length: { maximum: 40, message: "最大文字数は40文字です。" }

  validates :main_category_id,
  presence: { message: "メインカテゴリを選択してください。"}

  class << self
    def get_by_user_id(user_id)
      includes(:main_category)
      .where(user_id: user_id).order(updated_at: :desc)
    end
  end
end
