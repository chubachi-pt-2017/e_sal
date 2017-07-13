titles = [
  "配列を逆転させろ",
  "回文を探せ"
]

question_descs = [
  "以下の数値配列の要素順を逆にしなさい\n
  [1, 2, 3, 4, 5]",
  "2つの3桁のかけ算の積が回文(前から読んでも後ろから読んでも同じになる、例：22022, 123321など)で、かつ最大となる数を計算せよ。"
]

correct_answers = [nil, "906609"]

n = titles.length

0.upto(n - 1) do |num|
  Programming.create!(
    title: titles[num],
    question_desc: question_descs[num],
    correct_answer: correct_answers[num],
    user_id: 1
  )
  PublicActivity::Activity.create!(
    trackable_type: "Programming",
    trackable_id: num + 1,
    owner_type: "User",
    owner_id: 1,
    key: "programming.create",
    parameters: {
      link_url: "/e-sal/programming",
      title: titles[num]
    }
  )
end