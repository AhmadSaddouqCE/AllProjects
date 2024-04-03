import {
  AfterViewChecked,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { jwtDecode } from 'jwt-decode';
import { ToastrService } from 'ngx-toastr';
import { SettingsService } from './settings.service';
import { Router } from '@angular/router';
import { error } from 'jquery';
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html',
  styleUrl: './settings.component.css',
})
export class SettingsComponent implements OnInit, AfterViewChecked {
  name!: string;
  decodedToken!: any;
  token!: string;
  email!: string;
  address!: string;
  phone!: string;
  city!: string;
  country!: string;
  dateofbirth!: string;
  CustomerData!: any;
  @ViewChild('nameInput', { static: true })
  nameInput!: ElementRef<HTMLInputElement>;
  @ViewChild('emailInput', { static: true })
  emailInput!: ElementRef<HTMLInputElement>;
  @ViewChild('addressInput', { static: true })
  addressInput!: ElementRef<HTMLInputElement>;
  @ViewChild('cityInput', { static: true })
  cityInput!: ElementRef<HTMLInputElement>;
  @ViewChild('countryInput', { static: true })
  countryInput!: ElementRef<HTMLInputElement>;
  @ViewChild('oldPasswordInput', { static: true })
  oldPasswordInput!: ElementRef<HTMLInputElement>;
  @ViewChild('newPasswordInput', { static: true })
  newPasswordInput!: ElementRef<HTMLInputElement>;
  @ViewChild('confirmPasswordInput', { static: true })
  confirmPasswordInput!: ElementRef<HTMLInputElement>;
  @ViewChild('phoneInput', { static: true })
  phoneInput!: ElementRef<HTMLInputElement>;
  @ViewChild('dateOfBirthInput', { static: true })
  dateOfBirthInput!: ElementRef<HTMLInputElement>;
  constructor(
    private toastr: ToastrService,
    private settingsService: SettingsService,
    private router: Router,
    private datePipe: DatePipe
  ) {}
  ngAfterViewChecked(): void {}
  ngOnInit(): void {
    this.token = localStorage.getItem('token') || 'No Token Found';
    this.decodedToken = jwtDecode(this.token);
    this.getCustomerData();
    this.name =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
      ];
    this.email =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'
      ];
    this.phone =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/homephone'
      ];
  }
  formatDateForInput(dateString: string): string {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
  async getCustomerData() {
    await this.settingsService.getCustomerSettings().subscribe({
      next: (res: any[]) => {
        this.CustomerData = res;
        this.setInitialValues();
      },
      error: (error) => {
        this.toastr.error('Error Fetching Customer Data');
      },
    });
  }
  setInitialValues() {
    this.address = this.CustomerData.address;
    this.city = this.CustomerData.city;
    this.country = this.CustomerData.country;
    this.dateofbirth = this.formatDateForInput(this.CustomerData.dateOfBirth);
  }
  updatePassword() {
    let oldPassword = this.oldPasswordInput?.nativeElement.value;
    let newPassword = this.newPasswordInput?.nativeElement.value;
    let confirmPassword = this.confirmPasswordInput?.nativeElement.value;
    if (oldPassword === '' || newPassword === '' || confirmPassword === '')
      this.toastr.warning('Please fill all fields', 'Warning');
    else if (newPassword !== confirmPassword)
      this.toastr.warning("Password Doesn't Match", 'warning');
    else {
      const formData = new FormData();
      formData.append('password', oldPassword);
      formData.append('newPassword', newPassword);
      this.settingsService.updateCustomerPassword(formData).subscribe({
        next: (res) => {
          if (res.includes('Password Updated Succefully')) {
            this.toastr.success('Password Updated Succefully', 'Success');
            this.router.navigateByUrl('/Customer-Login');
          }
        },
        error: (error) => {
          this.toastr.error(error.error, 'Error');
        },
      });
    }
  }
  updateInfo() {
    let customerName = this.nameInput?.nativeElement.value;
    let customerEmail = this.emailInput?.nativeElement.value;
    let customerAddress = this.addressInput?.nativeElement.value;
    let customerCity = this.cityInput?.nativeElement.value;
    let customerCountry = this.countryInput?.nativeElement.value;
    let customerPhone = this.phoneInput?.nativeElement.value;
    let customerDateOfBirth = this.dateOfBirthInput?.nativeElement.value;
    if (
      customerName === '' ||
      customerEmail === '' ||
      customerAddress === '' ||
      customerCity === '' ||
      customerCountry === '' ||
      customerPhone === '' ||
      customerDateOfBirth === ''
    ) {
      this.nameInput.nativeElement.value = this.name;
      this.emailInput.nativeElement.value = this.email;
      this.addressInput.nativeElement.value = this.address;
      this.cityInput.nativeElement.value = this.city;
      this.phoneInput.nativeElement.value = this.phone;
      this.countryInput.nativeElement.value = this.country;
      this.dateOfBirthInput.nativeElement.value = this.dateofbirth;

      this.toastr.warning('Empty Data Are not Allowed', 'Warning');
    } else {
      const formData = new FormData();
      formData.append('name', customerName);
      formData.append('email', customerEmail);
      formData.append('address', customerAddress);
      formData.append('city', customerCity);
      formData.append('country', customerCountry);
      formData.append('phone', customerPhone);
      formData.append('dateOfBirth', customerDateOfBirth);

      this.settingsService.updateData_noPassword(formData).subscribe({
        next: (res) => {
          if (res.includes('Updated Succefully')) {
            if (this.name !== customerName || this.email !== customerEmail) {
              this.toastr.success('Updated Succefully', 'Success');
              localStorage.clear();
              this.router.navigateByUrl('/Customer-Login');
            } else {
              this.address = customerAddress
              this.city = customerCity
              this.country = customerCountry
              this.phone = customerPhone
              this.toastr.success('Updated Succefully', 'Success');
            }
          }
        },
        error: (error) => {
          if (error.error.includes('Email')) {
            this.toastr.warning(
              'This Email Already Exist. Try another One',
              'warning'
            );
            this.emailInput.nativeElement.value = this.email;
          }
          if (error.error.includes('Phone')) {
            this.toastr.warning(
              'This Phone number Already Exist. Try another One',
              'warning'
            );
            this.phoneInput.nativeElement.value = this.phone;
          }
          if (error.error.includes('Name')) {
            this.toastr.warning(
              'This Name Already Exist. Try another One',
              'warning'
            );
            this.nameInput.nativeElement.value = this.name;
          }
        },
      });
    }
  }
}
