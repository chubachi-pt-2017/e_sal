category_names = { 
  "[Language] Ruby": "ruby",
  "[Language] Python": "python",
  "[Language] PHP": "php",
  "[Language] Perl": "perl",
  "[Language] Java": "java",
  "[Language] C/C++": "c-language",
  "[Language] Go": "go",
  "[Language] Swift": "swift",
  "[Language] JavaScript": "javaScript",
  "[Language] HTML&CSS": "html-css",
  "[Language] bash/zsh/tcsh": "shell",
  "[Language] (others)": "other-lang",
  "[Framework] Ruby on rails": "ruby-on-rails",
  "[Framework] Django": "django",
  "[Framework] Zend": "zend",
  "[Framework] Symfony": "symfony",
  "[Framework] CakePHP": "cake-php",
  "[Framework] JSF": "jsf",
  "[Framework] Struts": "struts",
  "[Framework] Spring": "spring",
  "[Framework] Catalyst": "catalyst",
  "[Framework] (others)": "other-fw",
  "[DB] SQL (General)": "sql",
  "[DB] Oracle Database": "oracle",
  "[DB] IBM DB2": "db2",
  "[DB] Sybase ACE": "sybase",
  "[DB] PostgreSQL": "postgresql",
  "[DB] MySQL": "mysql",
  "[DB] SQLite": "sqlite",
  "[DB] (others)": "other-db",
  "[Network] Devices": "devices",
  "[Network] TCP/IP": "tcp-ip",
  "[Network] Security": "security",
  "[Network] (others)": "other-net",
  "[Cloud] AWS": "aws",
  "[Cloud] Heroku": "heroku",
  "[Cloud] Salesforce": "sfdc",
  "[Cloud] (others)": "other-cloud",
  "[VM] Xen": "xen",
  "[VM] kvm": "kvm",
  "[VM] VirtualBox": "virtualbox",
  "[VM] VMWare": "vmware",
  "[VM] (others)": "other-vm",
  "[OS] Linux": "linux",
  "[OS] Free/Open/Net BSD": "bsd",
  "[OS] MacOS": "mac",
  "[OS] Other UNIX": "other-unix",
  "[OS] Windows": "win",
  "[OS] DOS": "dos",
  "[OS] (others)": "other-os",
  "[Utility] Git": "git",
  "[Utility] Subversion": "subversion",
  "[Utility] Redmine": "redmine",
  "[Utility] (others)": "other-util",
  "[Others] ": "other-topics",
  }

category_names.each do |key, value|
  MainCategory.create!(
    name: key,
    name_url: value
    )
end

