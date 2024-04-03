import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironment } from 'src/app/environment';

@Injectable({
  providedIn: 'root',
})
export class EditUserService {
  constructor(private http: HttpClient, private globalEnv: GlobalEnvironment) {}
  public EditUser(formData: FormData) {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });

    return this.http.post(
      this.globalEnv.url + 'Admin/editCustomerDetails',
      formData,
      { headers, responseType: 'text' }
    );
  }
}
