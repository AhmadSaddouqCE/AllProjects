import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { GlobalEnvironmentService } from '../GlovalEnvinroment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class DoctorsService {
  constructor(
    private http: HttpClient,
    private router: Router,
    private routing: ActivatedRoute,
    private globalEnviroment: GlobalEnvironmentService
  ) {}
  getAllDoctors(): Observable<any[]> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<[]>(
      this.globalEnviroment.url + 'api/Doctor/getAllDoctors',
      {
        headers: headers,
      }
    );
  }
  addDoctor(formData: FormData): Observable<any> {
    return this.http.post(
      this.globalEnviroment.url + 'api/Doctor/addDoctor',
      formData,
      { responseType: 'text' }
    );
  }
  getDepartmentsByBranchId(branchId: string): Observable<any[]> {
    const header = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<[]>(
      ` ${
        this.globalEnviroment.url +
        'api/DepartmentsBranhces/getDepartmentByBranchId'
      }?branchId=${branchId}`,
      {
        headers: header,
      }
    );
  }
  getDoctors(page: number, pageSize: number = 5): Observable<any> {
    const header = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<any>(
      `${this.globalEnviroment.url+'api/Doctor/getDoctorsPagination'}?page=${page}&pageSize=${pageSize}`,
      {
        headers: header,
      }
    );
  }
}
