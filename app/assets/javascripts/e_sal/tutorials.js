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

  prepareForUploadImage();
});

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

  // var url = location.protocol + "://" + location.host + "/e_sal/photos"
  var pageType = $("#js-page-type").text();
  url = "photos"
  if (pageType == "edit") url = "/e-sal/photos";

  var xhr = new XMLHttpRequest();
  xhr.open('POST', url, true);
  xhr.onload = function () {
    if (xhr.status === 204) {
      // set_markdown_to_current_cursor_place();
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

// function set_markdown_to_current_cursor_place() {
//     var markdown = "![Altをここへ書く](ここはs3のURL)";
//     var textarea = $("#js-tutorial-body").focus();
//     var sentence = textarea.val();
//     var cursor_location = textarea.get(0).selectionStart;
//     textarea.val(sentence.substr(0, cursor_location) + shortcode + sentence.substr(cursor_location));

//     var end_of_inserted_location = cursor_location + shortcode.length;
//     textarea.get(0).setSelectionRange(end_of_inserted_location, end_of_inserted_location);
// }
