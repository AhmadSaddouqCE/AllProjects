import { BehaviorSubject, Observable } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, Injectable, OnInit } from '@angular/core';
import { GlobalEnvironment } from 'src/app/environment';

@Injectable({
  providedIn: 'root',
})
export class customerLoginServices {
  constructor(private http: HttpClient, private globarEnv: GlobalEnvironment) {}
  ngOnInit() {}

  private messageSubject = new BehaviorSubject<string>('');
  private sendName = new BehaviorSubject<string>('');
  private sendEmail = new BehaviorSubject<string>('');
  private sendPassword = new BehaviorSubject<string>('');
  private sendId = new BehaviorSubject<number>(0);
  private sendCity = new BehaviorSubject<string>('');
  private sendCountry = new BehaviorSubject<string>('');
  private sendAddress = new BehaviorSubject<string>('');
  private sendDate = new BehaviorSubject<string>('');
  private sendPhone = new BehaviorSubject<string>('');

  getId() {
    return this.sendId.asObservable();
  }
  setId(Id: number) {
    this.sendId.next(Id);
  }
  getCity() {
    return this.sendCity.asObservable();
  }
  setCity(City: string) {
    this.sendCity.next(City);
  }
  getCountry() {
    return this.sendCountry.asObservable();
  }
  setCountry(Country: string) {
    this.sendCountry.next(Country);
  }

  getDate() {
    return this.sendDate.asObservable();
  }
  setDate(dateofbirth: string) {
    this.sendDate.next(dateofbirth);
  }
  getAddress() {
    return this.sendAddress.asObservable();
  }
  setAddress(address: string) {
    this.sendAddress.next(address);
  }
  getPhone() {
    return this.sendPhone.asObservable();
  }
  setPhone(phone: string) {
    this.sendPhone.next(phone);
  }
  getName() {
    return this.sendName.asObservable();
  }
  setName(name: string) {
    this.sendName.next(name);
  }

  getEmail() {
    return this.sendEmail.asObservable();
  }
  setEmail(email: string) {
    this.sendEmail.next(email);
  }

  getPassword() {
    return this.sendPassword.asObservable();
  }
  setPassword(password: string) {
    this.sendPassword.next(password);
  }

  getMessage() {
    return this.messageSubject.asObservable();
  }

  setMessage(message: string) {
    this.messageSubject.next(message);
  }

  isLoggedIn(): boolean {
    return !!localStorage.getItem('token');
  }
  public LoginCustomers(user: Array<string>): Observable<any> {
    return this.http.post(
      this.globarEnv.url + 'Customer/loginUser',
      {
        Name: user[0],
        Password: user[1],
      },
      { headers: this.globarEnv.headers, responseType: 'text' }
    );
  }
}
