import { Observable } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, Injectable, OnInit } from '@angular/core';
import { GlobalEnvironment } from '../environment';

@Injectable({
  providedIn: 'root',
})
export class SignupService {
  constructor(private http: HttpClient, private globalEnv: GlobalEnvironment) {}

  public addCustomer(formData: FormData) {
  console.log(formData)
    return this.http.post(
      this.globalEnv.url + 'Customer/newCustomer',
      formData,
      { responseType: 'text' }
    );
  }
}
