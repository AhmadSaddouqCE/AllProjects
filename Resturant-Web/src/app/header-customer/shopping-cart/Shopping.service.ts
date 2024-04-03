import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { GlobalEnvironment } from 'src/app/environment';

@Injectable({
  providedIn: 'root',
})
export class ShoppingServices {

  constructor(private http: HttpClient, private globalEnv: GlobalEnvironment) {}
  getCustomerCarts(): Observable<any[]> {
    const token = localStorage.getItem('token');

    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.get<any[]>(this.globalEnv.url + 'Cart/getUserCarts', {
      headers,
    });
  }
  deleteCustomerCart(cartId: number): Observable<any> {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });
    return this.http.delete(
      `${this.globalEnv.url}Cart/DeleteFromCart/${cartId}`,
      { headers: headers, responseType: 'text' }
    );
  }
  editCustomerCartQuantity(form: FormData) {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      Authorization: `Bearer ${token}`,
    });
    return this.http.post(this.globalEnv.url + 'Cart/editCartQuantity', form, {
      headers, responseType:'text'
    })
  }
  addOrder(){
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    })
    return this.http.post(this.globalEnv.url + 'Order/AddOrder',null, {
     headers:headers, responseType:'text'
    })
  }
}
