$(function(){
  $(document).on('turbolinks:load', function(){

    function buildHTML(comment){
      var html =`<p>
                  <strong>${comment.user_name}</strong>
                  ${comment.content}
                  <a class="comment_delete_button" data-method="delete" href="/prototypes/${comment.prototype_id}/comments/${comment.id}">Delete</a>
                  <a class="comment_edit_button" href="/prototypes/${comment.prototype_id}/comments/${comment.id}/edit">Edit</a>
                </p>`
      return html;
    }

    $('form#new_comment').on('submit', function(e) {
      if( $(this).children('input[name="signin"]').attr('value') != undefined ){
        e.preventDefault();
        var formData = new FormData(this);
        var url = $(this).attr('action');
        $.ajax({
          url: url,
          type: 'POST',
          data: formData,
          dataType: 'json',
          processData: false,
          contentType: false
        })
        .done(function(data){
          var html = buildHTML(data);
          $('.comment_screen').append(html);
          $('input#comment_content').val("");
        })
        .fail(function(){
          alert('コメント送信が失敗しました');
        })
      };
    });
  });
});
