import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { GlobalEnvironmentService } from '../GlovalEnvinroment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class DepartmentService {
  constructor(
    private http: HttpClient,
    private router: Router,
    private routing: ActivatedRoute,
    private globalEnviroment: GlobalEnvironmentService
  ) {}
  getAllDepartments(): Observable<any[]> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<[]>(
      this.globalEnviroment.url + 'api/Department/getAllDepartments',
      {
        headers: headers,
      }
    );
  }
}
