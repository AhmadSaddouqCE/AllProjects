import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironmentService } from '../GlovalEnvinroment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class PatientService {
  constructor(
    private http: HttpClient,
    private globalEnviroment: GlobalEnvironmentService
  ) {}
  getAllPatients(): Observable<any[]> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<[]>(
      this.globalEnviroment.url + 'api/Patient/getAllPatients',
      {
        headers: headers,
      }
    );
  }
  addPatient(formData: FormData): Observable<any> {
    return this.http.post(
      this.globalEnviroment.url + 'api/Patient/addPatient',
      formData,
      {
        responseType: 'text',
      }
    );
  }
  getPatients(page: number, pageSize: number = 5): Observable<any> {
    const header = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<any>(
      `${
        this.globalEnviroment.url + 'api/Patient/getPatientsPagination'
      }?page=${page}&pageSize=${pageSize}`,
      {
        headers: header,
      }
    );
  }
}
