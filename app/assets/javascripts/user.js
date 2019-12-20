$(function(){

    var paramsNum = $('.params_num_user').data('params')

    $('#calendar-user').fullCalendar({

        timeFormat: "HH:mm",
        displayEventEnd: true,


        header:{
        left:"prev,next", //ヘッダー左側
        center: 'title', //ヘッダー中央
        right: 'month,agendaDay' //ヘッダー右側
        },

        eventSources:[
        {
            url: `/users/${paramsNum}.json`,
            color: '#02A553'
        },
        {
            url: `/users/${paramsNum}/edit.json`,
            color: '#6D3D1E'
        }
        ],


        eventMouseover: function(event, jsEvent, view){
            $(this).popover({
            placement: 'top',
            trigger: 'hover',
            container: 'body',
            content: event.start.format("HH:mm") + "〜" + event.end.format("HH:mm") + event.title,
        }).popover('toggle');
        }

    });

});
