class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # 半角数字のみ（特殊文字なし）
  VALID_HALF_DIGIT = /\A[0-9]+\z/
  
  # 半角英数字のみ（特殊文字なし）
  VALID_HALF_ABC_DIGIT = /\A[a-z0-9]+\z/
  
  # email
  VALID_EMAIL_DEFAULT = /\A\S+@\S+\.\S+\z/
  
  # 全角ひらがな、カタカナ、漢字のみ
  VALID_NORMAL_HIRA_KATA_KANJI = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/
  
end
