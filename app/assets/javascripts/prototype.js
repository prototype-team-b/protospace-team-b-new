$(function(){
  $(document).on('turbolinks:load', function(){

    // function buildHTML(prototype){
    //   var html =`<div class='row'>
    //               <div class='col-sm-4 col-md-3 proto-content'>
    //                 <div class='thumbnail'>
    //                   <a href="/prototypes/${prototype.id}"><img src="/uploads/captured_image/content/71/test_syansyan.jpg" /></a>
    //                   <div class='caption'>
    //                     <h3>${prototype.title}</h3>
    //                     <div class='proto-meta'>
    //                       <div class='proto-user'>
    //                         <a href="/users/${prototype.user_id}">${prototype.user_name}</a>
    //                         <div class='proto-destroy'></div>
    //                         <a rel="nofollow" data-method="delete" href="/prototypes/${prototype.id}">delete</a>
    //                         <div class='proto-edit'></div>
    //                         <a href="/prototypes/${prototype.id}/edit">edit</a>
    //                       </div>
    //                       <div class='proto-posted'>${prototype.date}</div>
    //                     </div>
    //                   </div>
    //                 </div>
    //               </div>
    //             </div>`
    //   return html;
    // }
    //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
    $('.cover-image-upload#main_image_uploader').on('change', 'input[type="file"]', function(e) {
      var file = e.target.files[0],
          reader = new FileReader(),
          $preview = $(".preview_main");
      // 画像ファイル以外の場合は何もしない
      if(file.type.indexOf("image") < 0){
        return false;
      }
      // ファイル読み込みが完了した際のイベント登録
      reader.onload = (function(file) {
        return function(e) {
          //既存のプレビューを削除
          $preview.empty();
          // .prevewの領域の中にロードした画像を表示するimageタグを追加
          $preview.append($('<img>').attr({
                    src: e.target.result,
                    width: "600px",
                    class: "preview",
                    title: file.name
                }));
        };
      })(file);
      reader.readAsDataURL(file);
    });
    //sub画像のプレビューを表示
    $('li.list-group-item.col-md-4').on('change', 'input[type="file"]', function(e) {
      var file = e.target.files[0],
          reader = new FileReader(),
          $preview = $(this).siblings().eq(0);
      // 画像ファイル以外の場合は何もしない
      if(file.type.indexOf("image") < 0){
        return false;
      }
      // ファイル読み込みが完了した際のイベント登録
      reader.onload = (function(file) {
        return function(e) {
          //既存のプレビューを削除
          $preview.empty();
          // .prevewの領域の中にロードした画像を表示するimageタグを追加
          $preview.append($('<img>').attr({
                    src: e.target.result,
                    width: "200px",
                    class: "preview",
                    title: file.name
                }));
        };
      })(file);
      reader.readAsDataURL(file);
    });
    //Newest順に並び替える
    // $('li.btn-default.btn-popular').on('click', function(e){
    //   e.preventDefault();
    //   $.ajax({
    //     url: '/prototypes',
    //     type: 'GET'
    //   })
    //   .done(function(data){
    //     console.log('doneしました');
    //     $('.container.proto-list').empty();
    //     $('.text-center').remove();
    //     $('.container.proto-list').append("= j(render partial: 'prototypes/prototype', collection: @all_prototypes)")
    //     // $('.container.proto-list').append
    //     // = render partial: 'prototypes/prototype', collection: @all_prototypes
    //   })
    //   .fail(function(){
    //     alert('Newestの並び替えが失敗しました')
    //   });
    // })
  });
});
