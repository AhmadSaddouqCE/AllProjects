import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { SideBarComponent } from './side-bar/side-bar.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AppRoutingModule } from './app.routing.module';
import { HeaderComponent } from './header/header.component';
import { DoctorsComponent } from './doctors/doctors.component';
import { AddDoctorComponent } from './doctors/add-doctor/add-doctor.component';
import { AngularFontAwesomeModule } from 'angular-font-awesome';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { LookupsListComponent } from './lookups-list/lookups-list.component';
import { PatientsComponent } from './patients/patients.component';
import { AddPatientComponent } from './patients/add-patient/add-patient.component';
import { AppointmentSetupComponent } from './appointment-setup/appointment-setup.component';
import { FullCalendarModule } from '@fullcalendar/angular';
import { CalendarAppointmentComponent } from './calendar-appointment/calendar-appointment.component';
import { NgMultiSelectDropDownModule } from 'ng-multiselect-dropdown';
import { DoctorsService } from './doctors/doctors.service';
import { GlobalEnvironmentService } from './GlovalEnvinroment';
import { HttpClientModule } from '@angular/common/http';
import { DepartmentService } from './DepartmentService/DepartmentService';
import { PatientService } from './patients/patients.Service';
import { lookupsService } from './lookups-list/lookups.service';
import { BranchesDepartmentComponent } from './branches-department/branches-department.component';
import { BranchesDepartmentsService } from './branches-department/branches-departments.serivce';
import { InfiniteScrollModule } from 'ngx-infinite-scroll';
import { ToastrModule, ToastrService } from 'ngx-toastr';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

@NgModule({
  declarations: [
    AppComponent,
    SideBarComponent,
    HeaderComponent,
    DoctorsComponent,
    AddDoctorComponent,
    LookupsListComponent,
    PatientsComponent,
    AddPatientComponent,
    AppointmentSetupComponent,
    CalendarAppointmentComponent,
    BranchesDepartmentComponent
    
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    FontAwesomeModule,
    FullCalendarModule,
    ReactiveFormsModule,
    NgMultiSelectDropDownModule.forRoot(),
    HttpClientModule,
    InfiniteScrollModule,
    ToastrModule.forRoot(),
    BrowserAnimationsModule

  ],
  providers: [
    DoctorsService,
    GlobalEnvironmentService,
    DepartmentService,
    PatientService,
    lookupsService,
    BranchesDepartmentsService,
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
