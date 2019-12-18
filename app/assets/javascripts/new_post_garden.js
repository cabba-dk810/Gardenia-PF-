$(function(){

    var paramsNum = $('.params_num').data('params')

    $('#calendar').fullCalendar({

        events: `/post_gardens/${paramsNum}/new_open_garden.json`,
        timeFormat: "HH:mm",
        displayEventEnd: true,


        header:{
        left:"prev,today,next", //ヘッダー左側
        center: 'title', //ヘッダー中央
        right: 'month,agendaWeek,agendaDay' //ヘッダー右側
        },

        dayClick: function(date, jsEvent, view){
        // カレンダー空白部分クリック時イベント
        $('#reservation-day-create').show();

        // カレンダーを選択した日付が入るように設定
        $('#open_day_start_time_1i').val(date.format( "YYYY" ));
        $('#open_day_start_time_2i').val(Number(date.format("MM")));
        $('#open_day_start_time_3i').val(Number(date.format( "DD" )));
        $('#open_day_start_time_4i').val("09");
        $('#open_day_start_time_5i').val("00");
        $('#open_day_end_time_1i').val(date.format( "YYYY" ));
        $('#open_day_end_time_2i').val(Number(date.format( "MM" )));
        $('#open_day_end_time_3i').val(Number(date.format( "DD" )));
        $('#open_day_end_time_4i').val("17");
        $('#open_day_end_time_5i').val("00");

        // alert('Clicked on: ' + date.format( 'YYYY/MM/DD' ));
        },

        eventClick: function(event, jsEvent, view){


        $('#reservation-day-update').show();
        $('#reservation-day-destroy').show();

        // 空欄部分をクリックした時と同じidを使わないようにするための処理
        update = $('#reservation-day-update')

        update.find('#open_day_start_time_1i').val(event.start.format( "YYYY" ));
        update.find('#open_day_start_time_2i').val(Number(event.start.format("MM")));
        update.find('#open_day_start_time_3i').val(Number(event.start.format( "DD" )));
        update.find('#open_day_start_time_4i').val(event.start.format( "HH" ));
        update.find('#open_day_start_time_5i').val(event.start.format( "mm" ));
        update.find('#open_day_end_time_1i').val(event.end.format( "YYYY" ));
        update.find('#open_day_end_time_2i').val(Number(event.end.format( "MM" )));
        update.find('#open_day_end_time_3i').val(Number(event.end.format( "DD" )));
        update.find('#open_day_end_time_4i').val(event.end.format( "HH" ));
        update.find('#open_day_end_time_5i').val(event.end.format( "mm" ));
        update.find('#open_day_id').val(event.id);
        // alert('Clicked on: ' + date.start.format("mm"));

        destroy = $('#reservation-day-destroy')

        destroy.find('#open_day_id').val(event.id);
        }

    });


    // カレンダーから日付選択画面を閉じる
    $(function(){
        $('.close-create').click(function(){
            $('#reservation-day-create').hide();
        });

        $('.close-update').click(function(){
            $('#reservation-day-update').hide();
            $('#reservation-day-destroy').hide();
        });

    });

});
