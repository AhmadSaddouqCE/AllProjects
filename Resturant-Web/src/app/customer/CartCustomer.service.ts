import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { GlobalEnvironment } from '../environment';
import { BehaviorSubject, Observable } from 'rxjs';
@Injectable({
  providedIn: 'root',
})
export class CartCustomerService {

  constructor(private http: HttpClient, private globalEnv: GlobalEnvironment) {}
  
}
