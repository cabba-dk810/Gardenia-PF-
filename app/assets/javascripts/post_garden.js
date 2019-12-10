// 庭公開時に追加で情報を入力させる時に使用（下記コード。参考に）

        // <div class="open_status_select">
        // <label><%= f.radio_button :open_status, "非公開", :onchange => 'openEntry(this)' %>  公開しない</label>
        // </div>
        // <div class="open_status_select">
        // <label><%= f.radio_button :open_status, "公開",  :onchange => 'openEntry(this)' %>  庭を公開する</label>
        // </div>

// function openEntry(radio){

//   $('#reservation_info').hide();

//   // 庭を公開しない
//   if ( radio.value == "公開" ) {
//     $('#reservation_info').show();

//     // 庭を公開する場合
//   } else{
//     $('#reservation_info').hide();
//   }
// }



// 複数枚ある投稿画像をスライドさせるときに使用
$(function(){

  $('.change-btn').click(function(){

    var $displaySlide = $('.active');
    $displaySlide.removeClass('active');
    if ($(this).hasClass('next-btn')){
      $displaySlide.next().addClass('active');
    } else{
      $displaySlide.prev().addClass('active');
    }

    // slideのactiveが何番目かslideIndexに番号を代入している
    var slideIndex = $('.slide').index($('.active'));
    // 基本は表示させておく（一回隠すと表示され無くなってしまうため
    $('.change-btn').show();

    if (slideIndex == 0){
      $('.prev-btn').hide();
    }else if (slideIndex == $('.slides').data('index') - 1){
      $('.next-btn').hide();
    }

  });
});