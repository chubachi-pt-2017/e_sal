$(function(){

  // 本文テキストカウント
  var bodyTextCount = $("#js-tutorial-body-count");
  var bodyText = $("#js-tutorial-body");
  bodyTextCount.text(bodyText.val().length);

  bodyText.on("keyup", function() {
    bodyTextCount.text(bodyText.val().replace(/[\n\s　]/g, "").length);
  });

  // タイトルテキストカウント
  var tutorialTitleCount = $("#js-tutorial-title-count");
  var tutorialTitle = $("#js-tutorial-title");
  tutorialTitleCount.text(tutorialTitle.val().length);

  tutorialTitle.on("keyup", function() {
    tutorialTitleCount.text(tutorialTitle.val().length);
  });  

  // 画像のアップロード処理を設定する
  prepareForUploadImage();

  // プレビューボタン
  $("#js-preview-button").on("click", function(){
    var tutorial_id = "";
    tutorial_id = $("#tutorial_id").val();

    var $selector = ""
    if (tutorial_id == "") {
      $selector = $("#new_tutorial");
    } else {
      $selector = $("#edit_tutorial_"+tutorial_id);
    }
    prepareForPreviewBeforeSend($selector);
  });

  // 更新ボタン
  $("#js-update-button").on("click", function(){
    var tutorial_id = "";
    tutorial_id = $("#tutorial_id").val();

    if (tutorial_id == "") {
      $("#new_tutorial").attr('target', "")
                        .attr('action', "/e-sal/tutorials");
    } else {
      $("#edit_tutorial_"+tutorial_id).attr('target', "")
                                      .attr('action', "/e-sal/tutorials/"+tutorial_id);
    }
  });
});

function prepareForPreviewBeforeSend($selector) {
  // プレビューのチュートリアルIDは0で統一
  $selector.attr("target", "preview_tutorial")
           .attr("action", "/e-sal/tutorials/preview/0");

  $("#js-preview-button").removeAttr('data-disable-with');
  $("#js-update-button").removeAttr('data-disable-with'); 
}

function prepareForUploadImage() {
  var imageDropZone = document.getElementById('js-image-drop-zone');
  imageDropZone.addEventListener('dragover', handleDragOver, false);
  imageDropZone.addEventListener('drop', handleFileSelect, false);
  imageDropZone.addEventListener('drop', showUploadHandling, false);
}

function handleFileSelect(evt) {
  evt.stopPropagation();
  evt.preventDefault();

  var files = evt.dataTransfer.files;
  var formData = new FormData();

  for (var i = 0, f; f = files[i]; i++) {
    formData.append('images[]', f, f.name);
  }

  formData.append('authenticity_token', document.getElementsByName("csrf-token")[0].content);
  formData.append('user_id', $("#tutorial_user_id").val());

  var pageType = $("#js-page-type").text();
  url = "photos"
  if (pageType == "edit") url = "/e-sal/photos";

  var xhr = new XMLHttpRequest();
  xhr.open('POST', url, true);
  xhr.onload = function () {
    if (xhr.status === 200 && xhr.readyState == 4) {
      var photoJSON = $.parseJSON(xhr.response)
      set_markdown_to_current_cursor_place(photoJSON);
      var imageDropZone = document.querySelector('#js-image-drop-zone');
      imageDropZone.textContent = "Please drop files here...";
      imageDropZone.style.backgroundColor = "";
      imageDropZone.style.color = "";
      prepareForUploadImage();
    } else {
      alert('An error occurred!');
    }
  };
  xhr.send(formData);
}

function handleDragOver(evt) {
  evt.stopPropagation();
  evt.preventDefault();
  evt.dataTransfer.dropEffect = 'copy';
}

function showUploadHandling(evt) {
  evt.preventDefault();
  var imageDropZone = document.querySelector('#js-image-drop-zone');
  imageDropZone.textContent = "uploading...";
  imageDropZone.style.backgroundColor = "#DDD";
  imageDropZone.style.color = "#FFF";
}

function set_markdown_to_current_cursor_place(photoJSON) {
  var markdown = "";
  for (var i = 0; i < photoJSON.photos.length; i++) {
    if (i => 1) markdown += "\r\n";
    markdown += "![Altをここへ書く](https://s3-ap-northeast-1.amazonaws.com/esal-dev/images/" + photoJSON.photos[i].id  + "/thumb_480" + photoJSON.photos[i].image_file_name.substr(photoJSON.photos[i].image_file_name.indexOf('.')) + ")";
  }

  var textarea = $("#js-tutorial-body").focus();
  var sentence = textarea.val();
  var cursor_location = textarea.get(0).selectionStart;
  textarea.val(sentence.substr(0, cursor_location) + markdown + sentence.substr(cursor_location));

  var end_of_inserted_location = cursor_location + markdown.length;
  textarea.get(0).setSelectionRange(end_of_inserted_location, end_of_inserted_location);
}
