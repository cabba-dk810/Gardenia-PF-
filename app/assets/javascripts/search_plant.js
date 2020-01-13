$(function(){
  $fileField = $('#file')

  // 選択された画像を取得し表示
  // ページが読み込まれた時にjsは読み込まれる。読み込まれた後にcocoonなどで要素を追加すると、動かない。(post_garden.jsのコードを参照)
  $($fileField).on('change', $fileField, function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $("#img_field");

    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        $preview.addClass("preview");
        //既存のプレビューを削除
        $preview.empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.append($('<img>').attr({
          src: e.target.result,
          class: "preview",
          width: "100%",
          height: "auto",
          title: file.name
        }));
      };
    })(file);

    // この処理をしてからonloadをする
    reader.readAsDataURL(file);
  });
});