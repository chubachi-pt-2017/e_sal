# Ace Editor
editor = ace.edit("ace-editor")

# Ace Editor Another Settings
editor.getSession().setMode("ace/mode/python")
editor.getSession().setTabSize(2)

# Ace Editor Settings
editor.$blockScrolling = Infinity
editor.setOptions
  enableBasicAutocompletion: true
  enableSnippets: true
  enableLiveAutocompletion: true
editor.setTheme("ace/theme/monokai")
editor.setFontSize(14)
editor.getSession().setUseWrapMode(true)
