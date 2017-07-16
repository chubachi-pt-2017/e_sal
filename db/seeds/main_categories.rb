category_names = { 
  "Git": "git",
  "Ruby": "ruby",
  "Python": "python",
  "Java": "java",
  "PHP": "php",
  "C言語": "c-language",
  "Go": "go",
  "Swift": "swift",
  "JavaScript": "javaScript",
  "HTML／CSS": "html",
  "CSS": "css",
  "Ruby on rails": "ruby-on-rails",
  "Django": "django",
  "CakePHP": "cake-php",
  "Linux": "linux",
  "Network": "network",
  "Security": "security"
  }

category_names.each do |key, value|
  MainCategory.create!(
    name: key,
    name_url: value
    )
end
