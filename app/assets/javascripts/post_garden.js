$(function(){

    var paramsNum = $('.params_num_show').data('params')

    $('#calendar_reservation').fullCalendar({
        events: `/post_gardens/${paramsNum}/new_open_garden.json`,
        timeFormat: "HH:mm",

        header:{
        left: '', //ヘッダー左側
        center: 'title', //ヘッダー中央
        right: 'prev,next' //ヘッダー右側
        },

        eventColor: '#02A553',
        eventBackgroundColor: '#02A553',
        // displayEventEnd: true,
        displayEventTime: false

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
