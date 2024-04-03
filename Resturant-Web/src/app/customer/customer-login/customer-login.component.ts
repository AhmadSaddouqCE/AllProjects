import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { customerLoginServices } from './customer.login.service';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-customer-login',
  templateUrl: './customer-login.component.html',
  styleUrls: ['./customer-login.component.css'],
})
export class CustomerLoginComponent implements OnInit {
  form!: FormGroup;
  Message = '';
  isAccountCreated: boolean = false;
  alert = '';
  showAlert: boolean = false;

  constructor(
    private fb: FormBuilder,
    private service: customerLoginServices,
    private router: Router,
    private currentRoute: ActivatedRoute
  ) {
    this.form = this.fb.group({
      name: [null, [Validators.required], []],
      password: [null, [Validators.required], []],
    });
  }
  ngOnInit() {
    localStorage.clear();
  }

  loginCustomer() {
    console.log(123)
    if (this.form.invalid) {
      this.showAlert = true;
      this.Message = '';
      return;
    }
    this.service
      .LoginCustomers([this.form.value.name, this.form.value.password])
      .subscribe({
        next: (res) => {
          const responseObj = JSON.parse(res);
          const token = responseObj.token;
          if (responseObj.status === 200) {
            this.Message = 'Welcome To Your Dashboard!';
            this.isAccountCreated = true;
            this.service.setMessage('Welcome to your dashboard!');
            const decodedToken: any = jwtDecode(token);
            localStorage.setItem('token', token);
            localStorage.setItem('Customer', 'true');
            this.router.navigateByUrl('/Dashboard');
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
        },
      });
  }
}
