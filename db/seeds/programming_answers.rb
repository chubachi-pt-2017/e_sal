# programmings = Programming.count

# 1.upto(programmings) do |num|
1.upto(10) do |num|
  ProgrammingAnswer.create!(
    programming_language: ProgrammingAnswer.programming_languages.values.sample,
    answer_code: "test",
    answer_result: "test_result",
    answer_status: ProgrammingAnswer.answer_statuses.values.sample,
    programming_id: num,
    user_id: 1
  )
  # PublicActivity::Activity.create!(
  #   trackable_type: "Programming",
  #   trackable_id: num + 1,
  #   owner_type: "User",
  #   owner_id: 1,
  #   key: "programming.create",
  #   parameters: {
  #     link_url: "/e-sal/programming",
  #     title: titles[num]
  #   }
  # )
end