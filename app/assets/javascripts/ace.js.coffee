# Ace Editor
editor = ace.edit("ace-editor")

# Setting TextArea
textarea = $('textarea[name="answer_code"]')
# editor.getSession().setValue textarea.val()
editor.getSession().on 'change', ->
  textarea.val() editor.getSession().getValue()
  return

# Ace Editor Another Settings
editor.$blockScrolling = Infinity
editor.setOptions
  enableBasicAutocompletion: true
  enableSnippets: true
  enableLiveAutocompletion: true
editor.setTheme("ace/theme/monokai")
editor.setFontSize(14)
editor.getSession().setMode("ace/mode/python")
editor.getSession().setUseWrapMode(true)
editor.getSession().setTabSize(2)
# editor.setReadOnly(true)

# Change TabSize
# $('#tab-size').click (e) ->
#   editor.session.setTabSize $(e.target).data('size')
#   return

# Change Language-Mode
# $ ($) ->
#   $('#mode-select').change ->
#     mode = $(this).val()
#     editor.session.setMode("ace/mode/" + mode)
#     return
#   return