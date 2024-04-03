import { NgModule } from '@angular/core';
import { RouterModule, Routes, CanActivate } from '@angular/router';
import { SideBarComponent } from './side-bar/side-bar.component';
import { AddDoctorComponent } from './doctors/add-doctor/add-doctor.component';
import { DoctorsComponent } from './doctors/doctors.component';
import { LookupsListComponent } from './lookups-list/lookups-list.component';
import { PatientsComponent } from './patients/patients.component';
import { AddPatientComponent } from './patients/add-patient/add-patient.component';
import { AppointmentSetupComponent } from './appointment-setup/appointment-setup.component';
import { CalendarAppointmentComponent } from './calendar-appointment/calendar-appointment.component';
import { BranchesDepartmentComponent } from './branches-department/branches-department.component';
;

const appRoutes: Routes = [
    { path: '', redirectTo: '/Dashboard', pathMatch: 'full' },
    { path: 'Dashboard', component: DoctorsComponent },
    { path: 'Add-Doctor', component: AddDoctorComponent },
    { path: 'Lookups', component: LookupsListComponent },
    { path: 'Patient', component: PatientsComponent },
    { path: 'Add-Patient', component: AddPatientComponent },
    { path: 'Appointment-Setup', component: AppointmentSetupComponent },
    { path: 'Calendar-Appointment', component: CalendarAppointmentComponent },
    { path: 'Department-Branches', component: BranchesDepartmentComponent },

    
];
@NgModule({
  imports: [RouterModule.forRoot(appRoutes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
