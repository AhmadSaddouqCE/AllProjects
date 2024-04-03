import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { GlobalEnvironment } from 'src/app/environment';

@Injectable({
  providedIn: 'root',
})
export class productService {
  constructor(private http: HttpClient, private globalEnv: GlobalEnvironment) {}
  getAllProducts(): Observable<any[]> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.get<any[]>(
      this.globalEnv.url + 'Products/getAllProducts',
      {
        headers,
      }
    );
  }
  addProduct(formData:FormData) {
    const token = localStorage.getItem('token');
    const header = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    })
  
    return this.http.post(
      this.globalEnv.url + 'Products/addProduct',
      formData,
      {headers:header, responseType: 'json' }
    );
  }
  editProduct(formData:FormData):Observable<any>{
    const token = localStorage.getItem('token')
    const header = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    })
    return this.http.post(this.globalEnv.url + 'Products/editProduct',formData,{
      headers:header, responseType:"text"
    })
  }
  public getProducts(): Observable<any[]> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.get<any[]>(
      this.globalEnv.url + 'Products/getAllProductsAdmin',
      { headers }
    );
  }
  public deleteProduct(productId:string):Observable<any>{
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.delete(
      `${this.globalEnv.url}Products/deleteProduct/${productId}`,
      { headers: headers, responseType: 'text' }
    );
  }
}
