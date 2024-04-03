import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironmentService } from '../GlovalEnvinroment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class BranchService {
  constructor(
    private http: HttpClient,
    private globalEnviroment: GlobalEnvironmentService
  ) {}
  getAllBranches(): Observable<any[]> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<[]>(
      this.globalEnviroment.url + 'api/Branch/getBranches',
      { headers: headers }
    );
  }
}
