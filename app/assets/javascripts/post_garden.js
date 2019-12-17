$(function(){
  // var calenderHTML = "";
  // console.log(#{@post_garden.id});

  $('#calendar_reservation').fullCalendar({
    events: '/post_gardens/3/new_open_garden.json',
    timeFormat: "HH:mm",

     header:{
      left:"prev,today,next", //ヘッダー左側
      center: 'title', //ヘッダー中央
      right: 'month,agendaWeek,agendaDay' //ヘッダー右側
      },

      eventClick: function(event, jsEvent, view, info){

        $('#reservation-day-decided').show();

        $('#reservation-select').val(event.start.format( 'YYYY/MM/DD' ));
        // alert('Clicked on: ' + date.start.format( 'YYYY/MM/DD/HH:mm' ) + '-' + date.end.format( 'YYYY/MM/DD/HH:mm' ));
    }


  });

  // カレンダーから日付選択画面を閉じる
  $(function(){
    $('.close-decided').click(function(){
      $('#reservation-day-decided').hide();
    });


  });


});




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
    }
    if (slideIndex == $('.slides').data('index') - 1){
      $('.next-btn').hide();
    }

  });

  // １枚しか投稿していない場合でも、ボタンが表示されない設定
  var slideIndex = $('.slide').index($('.active'));

    if (slideIndex == 0){
      $('.prev-btn').hide();
    }
    if (slideIndex == $('.slides').data('index') - 1){
      $('.next-btn').hide();
    }


});