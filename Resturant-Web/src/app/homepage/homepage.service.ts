import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironment } from '../environment';
import { Observable, map } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class HomepageService {
  constructor(private http: HttpClient, private globalEnv: GlobalEnvironment) {}

  public getbySearch(Element: Array<string>) {
    let params = new HttpParams().set('Name', Element[0]);

    return this.http.post<any[]>(
      this.globalEnv.url + 'Customer/SearchForElement?' + params.toString(),
      null,
      {
        headers: this.globalEnv.headers,
      }
    );
  }

  getAllUsers(): Observable<any[]> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    });

    return this.http.get<any[]>(this.globalEnv.url + 'Customer/getAllUsers', { headers });

  }
}
