import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironmentService } from '../GlovalEnvinroment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SetupSerive {
  constructor(
    private http: HttpClient,
    private globalEnviroment: GlobalEnvironmentService
  ) {}
  addDoctorSetup(timeEntries: any[]): Observable<any> {
    return this.http.post(
      this.globalEnviroment.url +
        'api/AppointmentSetup/addDoctorAppointmentSetup',
      timeEntries,
      {
        responseType: 'text',
      }
    );
  }
  getDoctorDetails(formData: FormData): Observable<any> {

    return this.http.post(
      this.globalEnviroment.url + 'api/AppointmentSetup/getDoctorDetails',
      formData,
      {
        responseType:'json'
      }
    );
  }
  getDoctorDepartments(formData: FormData): Observable<any> {
    const header = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.post(
      this.globalEnviroment.url +
        'api/DepartmentsBranhces/getDoctorsInBranches',
      formData,
      {
        responseType: 'json',
      }
    );
  }
}
