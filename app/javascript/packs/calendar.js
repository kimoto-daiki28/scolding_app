import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin ],

    locale: 'ja',
    timeZone: 'Asia/Tokyo',
    firstDay: 1,
    headerToolbar: {
      start: '',
      center: 'title',
      end: 'today prev,next' 
    },
    expandRows: true,
    stickyHeaderDates: true,
    buttonText: {
        today: '今日'
    }, 
    allDayText: '終日',
    height: "auto",

    dateClick: function(info){
        //日付をクリックしたときのイベント(詳しくは次回の記事へ)
    },
    eventClick: function(info){
        //表示されたイベントをクリックしたときのイベント(詳しくは次回の記事へ)
    },
    eventClassNames: function(arg){
        //表示されたイベントにclassをcss用に追加する(詳しくは次回の記事へ)
    }
  });

  calendar.render();
});
