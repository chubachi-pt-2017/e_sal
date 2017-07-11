category_names = { 
  "Git": "Git",
  "Ruby": "Ruby",
  "Python": "Python",
  "Java": "Java",
  "PHP": "PHP",
  "C言語": "C-Language",
  "Go": "Go-Language",
  "Swift": "Swift",
  "JavaScript": "JavaScript",
  "HTML／CSS": "HTML-CSS",
  "Ruby on rails": "Ruby-on-rails",
  "Django": "Django",
  "CakePHP": "CakePHP",
  "Linux": "Linux",
  "Network": "Network",
  "Security": "Security"
  }

category_names.each do |key, value|
  MainCategory.create!(
    name: key,
    name_url: value
    )
end
