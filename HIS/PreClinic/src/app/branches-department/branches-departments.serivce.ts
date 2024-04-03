import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironmentService } from '../GlovalEnvinroment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class BranchesDepartmentsService {
  constructor(
    private http: HttpClient,
    private GlobalEnviroment: GlobalEnvironmentService
  ) {}
  addBranch(formData: FormData): Observable<any> {
    return this.http.post(
      this.GlobalEnviroment.url + 'api/Branch/addBranch',
      formData,
      {
        responseType: 'json',
      }
    );
  }

  addDepartment(formData: FormData): Observable<any> {
    return this.http.post(
      this.GlobalEnviroment.url + 'api/Department/addDepartment',
      formData,
      {
        responseType: 'json',
      }
    );
  }
  addDepartmentToBranch(formData: FormData): Observable<any> {
    return this.http.post(
      this.GlobalEnviroment.url +
        'api/DepartmentsBranhces/addDepartmentToBranch',
      formData,
      {
        responseType: 'text',
      }
    );
  }
  
}
