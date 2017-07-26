# Add after page load event
Init = ->
  setAceEditor()
  return

if document.addEventListener
  document.addEventListener 'DOMContentLoaded', Init, false
else if document.attachEvent

  CheckReadyState = ->
    if document.readyState == 'complete'
      document.detachEvent 'onreadystatechange', CheckReadyState
      Init()
    return

  document.attachEvent 'onreadystatechange', CheckReadyState
  do ->
    try
      document.documentElement.doScroll 'left'
    catch e
      setTimeout arguments.callee, 10
      return
    document.detachEvent 'onreadystatechange', CheckReadyState
    Init()
    return
else
  Init()


setAceEditor = ->
  editor = ace.edit("ace-editor")
  mode = $('#js-lang').val()
  tab_size = $('#js-tab-size').val()
  editor.getSession().setMode("ace/mode/" + mode)
  editor.getSession().setTabSize(tab_size)
  textarea = $('#js-editor').val()
  editor.getSession().setValue textarea
  return

# Change Language-Mode
$ ($) ->
  $('#js-lang').change ->
    editor = ace.edit("ace-editor")
    mode = $(this).val()
    editor.session.setMode("ace/mode/" + mode)
    return
  return
  
# Change Tab-Szie
$ ($) ->
  $('#js-tab-size').change ->
    editor = ace.edit("ace-editor")
    tab_size = $(this).val()
    editor.getSession().setTabSize(tab_size)
    return
  return
  
# Change Document
$ ($) ->
  ace.edit("ace-editor").on 'change', ->
    editor = ace.edit("ace-editor")
    $('#js-editor').val editor.getSession().getValue()
    return
  return


putSubmit = ->
  lang = $('#js-lang').val()
  code = $('#js-editor').val()
  programming_id = $('#js-programming-id').val()
  $.ajax(
    url: '/e-sal/programming/' + programming_id + '/answer/submit'
    type: 'GET'
    dataType: 'json'
    # async: true
    data:
      lang: lang
      code: code).success((data) ->
        console.log(data)
        $('#js-result-area').text("")
        $('#js-result-area').text data.stdout
        return
  ).error (data) ->
    alert 'プログラムの実行に失敗しました'
    return
  return

# Click Submit
$ ($) ->
  $('#js-programming-submit').on 'click', ->
    putSubmit()
    return
  return
