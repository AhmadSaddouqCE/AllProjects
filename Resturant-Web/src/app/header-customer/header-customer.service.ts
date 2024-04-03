import { BehaviorSubject, Observable } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, Injectable, OnInit } from '@angular/core';
import { GlobalEnvironment } from '../environment';
import { jwtDecode } from 'jwt-decode';

@Injectable({
  providedIn: 'root',
})
export class headerCustomerServices implements OnInit {

  constructor(private http: HttpClient, private gobalEnv: GlobalEnvironment) {}
  ngOnInit() {}
  private cartLengthSubject: BehaviorSubject<number> =
    new BehaviorSubject<number>(0);
  getCustomerOrderList(): Observable<any[]> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.get<any[]>(this.gobalEnv.url + 'Order/GetOrderDetails', {
      headers,
    });
  }
  deleteOrder(orderId: number): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.delete(
      `${this.gobalEnv.url}Order/DeleteOrder/${orderId}`,
      { headers: headers, responseType: 'text' }
    );
  }
  getOrdersById(orderId: string): Observable<any[]> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.post<any[]>(
      this.gobalEnv.url + 'Order/getOrderDetailsById',
      orderId,
      {
        headers,
      }
    );
  }
  setCartLength(length: number): void {
    this.cartLengthSubject.next(length);
  }
  getCartLength(): Observable<number> {
    return this.cartLengthSubject.asObservable();
  }
  addToCart(formData: FormData) {
    return this.http.post(this.gobalEnv.url + 'Cart/newCart', formData, {
      responseType: 'text',
    });
  }
  getPrdouctsByCategoryId(categoryId:string):Observable<any>{
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.get(
      `${this.gobalEnv.url}Category/getProductByCategoryId/${categoryId}`,
      { headers: headers}
    );
  }
  getAllCategories():Observable<any>{
    const token = localStorage.getItem('token')
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.get<any[]>(this.gobalEnv.url + 'Category/getAllCategories', {
      headers,
    });
  }
  DeleteProductFromOrder(formData: FormData): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });
    return this.http.post(
      this.gobalEnv.url + 'Order/deleteProductFromOrder',
      formData,
      {
        headers,
        responseType: 'text',
      }
    );
  }

  modifyProductToList(formData: FormData): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });

    return this.http.post(
      this.gobalEnv.url + 'Order/modifyNewProductToTheCart',
      formData,
      {
        headers,
        responseType: 'text',
      }
    );
  }
}
