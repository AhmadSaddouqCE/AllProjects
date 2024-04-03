import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GlobalEnvironment } from 'src/app/environment';

@Injectable({
  providedIn: 'root',
})
export class SettingsService {
  constructor(private globalEnv: GlobalEnvironment, private http: HttpClient) {}
  public updateData_noPassword(formData: FormData): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });
    return this.http.post(
      this.globalEnv.url + 'Customer/editCustomer_noPassword',
      formData,
      {
        headers: headers,
        responseType: 'text',
      }
    );
  }
  public getCustomerSettings(): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`

    });
    return this.http.get(this.globalEnv.url + 'Customer/getUserById',{
      headers:headers, 
    })
  }
  public updateCustomerPassword(formData: FormData): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });
    return this.http.post(
      this.globalEnv.url + 'Customer/editCustomerPassword',
      formData,
      {
        headers: headers,
        responseType: 'text',
      }
    );
  }
}
