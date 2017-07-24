$(function(){

  // チュートリアル新規作成or編集ページだったら
  if ($("#js-page-type").text() == "new" || $("#js-page-type") == "edit") {
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
  }

  // チュートリアル詳細ページ
  if ($("#js-page-type").text() == "show") {
    // いいねボタン
  	$("#js-like-button").on('click', function(e) {
  	  var state = $(this).attr("data-like");
  	  var method = "";

  	  if ( state == "on" ) {
  	    method = "post";
  	  } else if ( state == "off" ) {
  	    method = "delete";
  	  }

  	  $.ajax({
        type: method,
        url: "/e-sal/tutorials/tutorial-like",
        data: {
          tutorial_id: $("#js-tutorial-id").text(),
          user_id: $("#js-user-id").text()
        }
      }).success(function(data) {
        if (state == "on") {
          $("#js-like-numbers").text(parseInt($("#js-like-numbers").text()) + 1);
      		$("#js-like-button").html('<i class="fa fa-heart" aria-hidden="true"></i> You liked this');
      		$("#js-like-button").children('.fa-heart').addClass('js-animate-like-dislike-button');
      		$("#js-like-button").css('width','180px');
      		$("#js-like-button").attr("data-like", "off");
        }else if (state == "off") {
          $("#js-like-numbers").text(parseInt($("#js-like-numbers").text()) - 1);
      		$("#js-like-button").html('<i class="fa fa-heart" aria-hidden="true"></i> Like');
      		$("#js-like-button").children('.fa-heart').addClass('js-animate-like-dislike-button');
      		$("#js-like-button").css('width','108px');
      		$("#js-like-button").attr("data-like", "on");
        }
      }).error(function(data) {
        alert("データベースの更新に失敗しました。再度likeボタンを押してください。");
        return false;
      });
  	});
  
    // よくないねボタン
  	$(document).on('click', '#js-dislike-button', function(e) {
  	  var state = $(this).attr("data-like");
  	  var method = "";

  	  if ( state == "on" ) {
  	    method = "post"
  	  } else if ( state == "off" ) {
  	    method = "delete"
  	  }

  	  $.ajax({
        type: method,
        url: "/e-sal/tutorials/tutorial-dislike",
        data: {
          tutorial_id: $("#js-tutorial-id").text(),
          user_id: $("#js-user-id").text()
        }
      }).success(function(data) {
        if (state == "on") {
      	  $("#js-dislike-numbers").text(parseInt($("#js-dislike-numbers").text()) + 1);
      		$("#js-dislike-button").html('<i class="fa fa-bolt" aria-hidden="true"></i> You disliked this');
      		$("#js-dislike-button").children('.fa-bolt').addClass('js-animate-like-dislike-button');
      		$("#js-dislike-button").css('width','180px');
      		$("#js-dislike-button").attr("data-like", "off");
      	} else if (state == "off") {
      	  $("#js-dislike-numbers").text(parseInt($("#js-dislike-numbers").text()) - 1);
      		$("#js-dislike-button").html('<i class="fa fa-bolt" aria-hidden="true"></i> Dislike');
      		$("#js-dislike-button").children('.fa-bolt').addClass('js-animate-like-dislike-button');
      		$("#js-dislike-button").css('width','108px');
      		$("#js-dislike-button").attr("data-like", "on");
      	}
      }).error(function(data) {
        alert("データベースの更新に失敗しました。再度dislikeボタンを押してください。");
        return false;
      });
  	});
  }

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
