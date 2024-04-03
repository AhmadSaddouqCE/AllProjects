import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, NgForm, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { SignupService } from './sign-up.service';
import { count } from 'rxjs';
@Component({
  selector: 'app-sign-up',
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.css'],
})
export class SignUpComponent implements OnInit {
  isAccountCreated: boolean = false;
  alert = true;
  form!: FormGroup;
  Message = '';

  constructor(
    private fb: FormBuilder,
    private service: SignupService,
    private router: Router,
    private currentRoute: ActivatedRoute
  ) {
    this.form = this.fb.group({
      name: [null, [Validators.required], []],
      email: [null, [Validators.required], []],
      password: [null, [Validators.required], []],
      city: [null, [Validators.required], []],
      country: [null, [Validators.required], []],
      address: [null, [Validators.required], []],
      dateofbirth: [null, [Validators.required], []],
      phone: [null, [Validators.required], []],
    });
  }

  ngOnInit() {}
  Check(
    name: string,
    email: string,
    password: string,
    country: string,
    city: string,
    address: string,
    dateofbirth: string,
    phone: string
  ) {
    if (
      name !== '' &&
      email !== '' &&
      password !== '' &&
      country !== '' &&
      city !== '' &&
      address !== '' &&
      dateofbirth !== '' &&
      phone !== ''
    ) {
      this.alert = true;
      return true;
    }
    this.alert = false;
    return false;
  }
  public submit() {
    const formData = new FormData();
    formData.append('Name', this.form.value.name);
    formData.append('Email', this.form.value.email);
    formData.append('Password', this.form.value.password);
    formData.append('City', this.form.value.city);
    formData.append('Country', this.form.value.country);
    formData.append('Address', this.form.value.address);
    formData.append('DateOfBirth', this.form.value.dateofbirth);
    formData.append('Phone', this.form.value.phone);
    this.service
      .addCustomer(formData)

      .subscribe({
        next: (res) => {
          if (res.includes('Created')) {
            this.Message = 'New user created Successfully!';
            this.isAccountCreated = true;
            this.router.navigateByUrl('/login');
            alert('New User Created');
          }
        },
        error: (error) => {
          if (
            error.status === 500 &&
            error.error.includes('This name already exists')
          ) {
            this.Message = 'Username Already Exists';
            this.isAccountCreated = false;
          } else if (
            error.status === 500 &&
            error.error.includes('This email already exists')
          ) {
            this.Message = 'Email already exists';
            this.isAccountCreated = false;
          } else if (
            error.status === 500 &&
            error.error.includes('This Phone already exists')
          ) {
            this.Message = 'Phone already exists';
            this.isAccountCreated = false;
          }
        },
      });
  }
}
