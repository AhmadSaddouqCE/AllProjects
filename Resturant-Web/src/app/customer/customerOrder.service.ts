import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable, OnInit } from '@angular/core';
import { GlobalEnvironment } from '../environment';

@Injectable({
  providedIn: 'root',
})
export class customerOrderService implements OnInit {
  constructor(private http: HttpClient, private glovalEnv: GlobalEnvironment) {}
  ngOnInit() {}
  public AddNewOrder(Order: string[][]) {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    });

    return this.http.post(
      this.glovalEnv.url + 'Order/addOrder',
      {
        productId: Order[0][0],
        Price: Order[0][1],
        Quantity: Order[0][2],
        customerId: Order[0][3],
      },
      { headers, responseType: 'text' }
    );
  }
}
