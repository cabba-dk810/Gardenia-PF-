$(function(){

    var paramsNum = $('.params_num_reservation').data('params')

    $('#calendar-reservation').fullCalendar({

        events: `/post_gardens/${paramsNum}/new_open_garden.json`,
        timeFormat: "HH:mm",
        displayEventEnd: true,


        header:{
        left:"prev,today,next", //ヘッダー左側
        center: 'title', //ヘッダー中央
        right: 'month,agendaWeek,agendaDay' //ヘッダー右側
        },

        eventClick: function(event, jsEvent, view){

        $('#reservation_r_start_datetime_1i').val(event.start.format( "YYYY" ));
        $('#reservation_r_start_datetime_2i').val(Number(event.start.format("MM")));
        $('#reservation_r_start_datetime_3i').val(Number(event.start.format( "DD" )));
        $('#reservation_r_start_datetime_4i').val(event.start.format( "HH" ));
        $('#reservation_r_start_datetime_5i').val(event.start.format( "mm" ));
        $('#reservation_r_end_datetime_1i').val(event.end.format( "YYYY" ));
        $('#reservation_r_end_datetime_2i').val(Number(event.end.format( "MM" )));
        $('#reservation_r_end_datetime_3i').val(Number(event.end.format( "DD" )));
        $('#reservation_r_end_datetime_4i').val(event.end.format( "HH" ));
        $('#reservation_r_end_datetime_5i').val(event.end.format( "mm" ));
        $('#reservation_id').val(event.id);
        // alert('Clicked on: ' + date.start.format("mm"));

        }

    });

});
