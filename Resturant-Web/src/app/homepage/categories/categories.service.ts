import { HttpClient, HttpHandler, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GlobalEnvironment } from 'src/app/environment';

@Injectable({
  providedIn: 'root',
})
export class CategoryService {
  constructor(private http: HttpClient, private globalEnv: GlobalEnvironment) {}
  addCategory(formData: FormData): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });
    return this.http.post(
      this.globalEnv.url + 'Category/addCategory',
      formData,
      { headers, responseType: 'json' }
    );
  }
  deleteCategory(categoryId: string): Observable<any> {
    const token = localStorage.getItem('token');
    const header = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.delete(
      `${this.globalEnv.url}Category/deleteCategory/${categoryId}`,
      { headers: header, responseType: 'text' }
    );
  }
  modifyCategory(formData: FormData): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });
    return this.http.post(
      this.globalEnv.url + 'Category/modifyCategory',
      formData,
      {
        headers: headers,
        responseType: 'text',
      }
    );
  }
}
