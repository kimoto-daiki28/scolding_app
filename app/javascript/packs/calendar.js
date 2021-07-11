import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin ],
    initialView: 'dayGridMonth',

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

    events: '/my_page.json',
  });

  calendar.render();
});
