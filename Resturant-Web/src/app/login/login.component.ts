import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { GlobalEnvironment } from '../environment';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, NavigationExtras, Router } from '@angular/router';
import { LoginServices } from './login.service';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  form!: FormGroup;
  Message = '';
  isAccountCreated: boolean = false;
  alert = '';
  showAlert: boolean = false;
  constructor(
    private fb: FormBuilder,
    private service: LoginServices,
    private router: Router,
    private currentRoute: ActivatedRoute
  ) {
    this.form = this.fb.group({
      name: [null, [Validators.required], []],
      password: [null, [Validators.required], []],
    });
  }
  ngOnInit() {
    localStorage.clear()
  }

  LoginAdmin() {
    if (this.form.invalid) {
      this.showAlert = true;
      this.Message = '';
      return;
    }
    var name = this.form.value.name 
    var password = this.form.value.password
    const formData = new FormData()
    formData.append("name", name) 
    formData.append("password", password)  
 

    this.service
      .LoginAdmin(formData)
      .subscribe(
        {
       next: (res) => {
          const responseObj = JSON.parse(res);
          const token = responseObj.token;
          if (responseObj.status === 200) {
            this.Message = 'Welcome To Your Dashboard!';
            this.isAccountCreated = true;
            this.service.setMessage('Welcome to your dashboard!');
            const token = responseObj.token;
            localStorage.setItem('token', token);
            localStorage.setItem('admin', "true")
            this.router.navigateByUrl('/Homepage');
          }
        },
        error: (error) => {

          if (
            error.status === 500 ||
            error.error.includes('Wrong Credentials, Try Again.')
          ) {
            this.Message = 'Wrong Credintials, Try Again.';
            this.showAlert = false;
            this.isAccountCreated = false;
          }
        }
  });
  }
}
