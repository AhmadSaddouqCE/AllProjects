import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironmentService } from '../GlovalEnvinroment';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class lookupsService {
  constructor(
    private http: HttpClient,
    private globalEnviroment: GlobalEnvironmentService
  ) {}
  addCategory(formData: FormData): Observable<any> {
    return this.http.post(
      this.globalEnviroment.url + 'api/SystemlookupsCategory/addCategory',
      formData,
      {
        responseType: 'text',
      }
    );
  }
  getCategories(): Observable<any> {
    const header = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<any>(
      this.globalEnviroment.url + 'api/SystemlookupsCategory/getCategories',
      {
        headers: header,
      }
    );
  }
  getLookups(): Observable<any> {
    const header = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<any>(
      this.globalEnviroment.url + 'api/Systemlookups/getAllLookups',
      {
        headers: header,
      }
    );
  }
  getLookupsById(Id: string): Observable<any[]> {
    const hedaer = new HttpHeaders({
      'Content-Type': 'application/json',
    });
    return this.http.get<any[]>(
      ` ${
        this.globalEnviroment.url + 'api/Systemlookups/getItemsBasedOnCode'
      }?categoryId=${Id}`,
      {
        headers: hedaer,
      }
    );
  }
}
