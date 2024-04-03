import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { HomepageComponent } from '../homepage.component';
import { HomepageService } from '../homepage.service';
import { LoginServices } from 'src/app/login/login.service';
import { EditUserService } from './edit.user.service';
import { count } from 'rxjs';

@Component({
  selector: 'app-edit-user',
  templateUrl: './edit-user.component.html',
  styleUrls: ['./edit-user.component.css'],
})
export class EditUserComponent implements OnInit {
  @ViewChild('nameInput', { static: true })
  nameInput!: ElementRef<HTMLInputElement>;
  @ViewChild('emailInput', { static: true })
  emailInput!: ElementRef<HTMLInputElement>;
  @ViewChild('passwordInput', { static: true })
  passwordInput!: ElementRef<HTMLInputElement>;
  @ViewChild('dateOfBirthInput', { static: true })
  dateOfBirthInput!: ElementRef<HTMLInputElement>;
  @ViewChild('countryInput', { static: true })
  countryInput!: ElementRef<HTMLInputElement>;
  @ViewChild('cityInput', { static: true })
  cityInput!: ElementRef<HTMLInputElement>;
  @ViewChild('addressInput', { static: true })
  addressInput!: ElementRef<HTMLInputElement>;
  @ViewChild('phoneNumberInput', { static: true })
  phoneNumberInput!: ElementRef<HTMLInputElement>;
  customers: any[] = [];
  isAccountCreated: boolean = false;
  alert = true;
  Message = '';
  username = '';
  email = '';
  password = '';
  city = '';
  country = '';
  address = '';
  phone = '';
  date = '';
  Id = 0;
  form!: FormGroup;
  constructor(
    private fb: FormBuilder,
    private router: Router,
    private currentRoute: ActivatedRoute,
    private hoempageService: HomepageService,
    private loginService: LoginServices,
    private editService: EditUserService
  ) {
    this.form = this.fb.group({
      name: [this.username, [Validators.required], []],
      email: [this.email, [Validators.required], []],
      password: [null, [Validators.required], []],
      city: [this.city, [Validators.required], []],
      country: [this.country, [Validators.required], []],
      address: [this.address, [Validators.required], []],
      dateofbirth: [this.date, [Validators.required], []],
      phone: [this.phone, [Validators.required], []],
    });
  }

  ngOnInit(): void {
    this.getAllUsers();
  }

  Check() {
    const name = this.nameInput?.nativeElement?.value;
    const email = this.emailInput?.nativeElement?.value;
    const password = this.passwordInput?.nativeElement?.value;
    const city = this.cityInput?.nativeElement?.value;
    const address = this.addressInput?.nativeElement?.value;
    const country = this.countryInput?.nativeElement?.value;
    const dateofbirth = this.dateOfBirthInput?.nativeElement?.value;
    const phone = this.phoneNumberInput?.nativeElement?.value;

    if (
      name !== '' &&
      email !== '' &&
      password !== '' &&
      city !== '' &&
      address !== '' &&
      country !== '' &&
      dateofbirth !== '' &&
      phone !== ''
    ) {
      this.alert = true;
      return true;
    }
    this.Message = 'Please Fill All The Fields ';
    return false;
  }
  getAllUsers(): void {
    this.hoempageService.getAllUsers().subscribe({
      next: (data: any[]) => {
        this.customers = data;
      },
      error: (error) => {
        console.error('Error fetching customers:', error);
      },
    });
  }

  submit() {
    const formData = new FormData();
    formData.append('customerId', this.Id.toString());
    formData.append('name', this.form.value.name);
    formData.append('email', this.form.value.email);
    formData.append('Password', this.form.value.password);
    formData.append('city', this.form.value.city);
    formData.append('country', this.form.value.country);
    formData.append('address', this.form.value.address);
    formData.append('dateOfBirth', this.form.value.dateofbirth);
    formData.append('phone', this.form.value.phone);
    this.editService.EditUser(formData).subscribe({
      next: (res) => {
        if (res.includes('Updated Succefully')) {
          this.Message = 'Updated Successfully!';
          this.isAccountCreated = true;
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
  openEditModal(customerData: any) {
    this.username = this.form.get('name')?.setValue(customerData.name) ?? '';
    this.email = this.form.get('email')?.setValue(customerData.email) ?? '';
    this.address =
      this.form.get('address')?.setValue(customerData.address) ?? '';
    this.city = this.form.get('city')?.setValue(customerData.city) ?? '';
    this.phone = this.form.get('phone')?.setValue(customerData.phone) ?? '';
    this.date = this.form.get('dateofbirth')?.setValue(customerData.date) ?? '';
    this.country =
      this.form.get('country')?.setValue(customerData.country) ?? '';
    this.Id = customerData.customerId;
    this.Message = '';
    this.passwordInput.nativeElement.value = '';
  }
}
