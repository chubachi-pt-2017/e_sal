class ESalNotFound < Exception
  def initialize
    super("ページが見つかりませんでした。")
  end
end