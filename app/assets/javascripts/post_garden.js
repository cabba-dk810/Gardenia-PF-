c = 0
for(i=r=0;i<100;r+=(++i)**4);
    console.log(c = c + i)
// new画像のプレビュー
let counter = 0;

$(function(){

  // 選択された画像を取得し表示
  // document.addEventListener(function(e))
  // 画像を追加するたびにchangeイベントを発生させたいので、.new-post-imageがchangeした時と定義している。
    $(document).on('change', '.new-post-image', function(e) {
        var file = e.target.files[0],
            reader = new FileReader(),
            // previewにidを指定していると複数枚の認識がうまくいかないので、input(e.target)要素の親のクラスをpreviewに代入する
            $preview = $(e.target).parent();

            $('.new_img_field').hide();

        // 画像ファイル以外の場合は何もしない
        if(file.type.indexOf("image") < 0){
            return false;
        }

        // ファイル読み込みが完了した際のイベント登録
        reader.onload = (function(file) {
            return function(e) {
                // attachment_field消える
                // $preview.empty();
                $preview.addClass("preview");
                // .prevewの領域の中にロードした画像を表示するimageタグを追加
                $preview.append($('<img>').attr({
                  src: e.target.result,
                  class: "preview",
                  width: "100%",
                  height: "100%",
                  title: file.name
                }));

                $.ajax({
                    url: "send_images",
                    type: 'post',
                    // e.target.resultだけだと、画像のコードの先頭にHTMLで表示するためのコードが入ってしまうので、splitで除く
                    data: {image :e.target.result.split(',')[1]}
                })
                .done(function(data){
                    $('.auto-keyword').show();
                    for(var i = 0; i <= 4; i++) {
                        // $previewからnext()を使ってauto-keywordクラスを取得すると、各画像に紐づいてタグをつけられる
                        $auto_keyword = $preview.next().children('.auto-keyword-text-' + [i]);
                        $auto_keyword.append(data[i]["keyword"]);
                    }

                })
                .fail(function(err){
                    console.log('エラーが発生しました')
                })
            };
        })(file);

        // この処理をしてからonloadをする
        reader.readAsDataURL(file);

    });
});


// show画面公開中かどうか表示している小さなカレンダー
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