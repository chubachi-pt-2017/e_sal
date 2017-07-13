1.upto(20) do |n|
  User.create!(
    email: "example_#{n}@aiit.ac.jp",
    password: "e_sal_test",
    sign_in_count: 0,
    confirmed_at: Time.zone.now,
    user_name: "テスト太郎",
    student_id: "#{(15745200+n).to_s}",
    student_id_confirmation: "#{(15745200+n).to_s}",
    second_email: "example_#{n}@gmail.ac.jp",
    gender: User.genders.values.sample,
    age: User.ages.values.sample,
    course_type: User.course_types.values.sample,
    # job: User.jobs.values.sample,
    term_flg: true
  )
end