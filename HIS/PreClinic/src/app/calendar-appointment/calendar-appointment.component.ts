import { Component } from '@angular/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import { CalendarOptions } from '@fullcalendar/core';
import interactionPlugin from '@fullcalendar/interaction';
@Component({
  selector: 'app-calendar-appointment',
  templateUrl: './calendar-appointment.component.html',
  styleUrl: './calendar-appointment.component.css'
})
export class CalendarAppointmentComponent {
  isSidebarExpanded = false
  selectedStatus:string = 'Keep it empty if new Patient'
  calendarOptions: CalendarOptions = {
    initialView: 'dayGridMonth',
    plugins: [dayGridPlugin, interactionPlugin],
    dateClick: (arg) => this.handleDateClick(arg),
    events: [
      { title: 'event 1', date: '2024-04-01' },
      { title: 'event 2', date: '2024-04-02' }
    ]
  };

  handleDateClick(arg:any) {
    alert('date click! ' + arg.dateStr)
  }
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }
}
