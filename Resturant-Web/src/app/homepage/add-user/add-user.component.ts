import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { HomepageService } from '../homepage.service';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { SignupService } from 'src/app/sign-up/sign-up.service';
import { count } from 'rxjs';

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.css'],
})
export class AddUserComponent implements OnInit {
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
  form!: FormGroup;
  selectedFile: File | null = null;

  showModal: boolean = false;
  Message = '';
  constructor(
    private fb: FormBuilder,
    private service: SignupService,
    private router: Router,
    private currentRoute: ActivatedRoute,
    private hoempageService: HomepageService
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
  ngOnInit(): void {
    this.getAllUsers();
  }

  openModal() {
    this.showModal = true;
  }

  closeModal() {
    this.showModal = false;
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
    this.Message = 'Please Fill All The Fields';
    return false;
  }

  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }
  resetData(){
    this.Message = ''
    this.isAccountCreated = false
    this.nameInput.nativeElement.value = ''
    this.addressInput.nativeElement.value = ''
    this.cityInput.nativeElement.value = ''
    this.countryInput.nativeElement.value = ''
    this.dateOfBirthInput.nativeElement.value = ''
    this.passwordInput.nativeElement.value = ''
    this.phoneNumberInput.nativeElement.value = ''
    this.emailInput.nativeElement.value = ''
  }
  public submit() {
    const formData = new FormData();
    formData.append('name', this.form.value.name);
    formData.append('email', this.form.value.email);
    formData.append('password', this.form.value.password);
    formData.append('city', this.form.value.city);
    formData.append('country', this.form.value.country);
    formData.append('address', this.form.value.address);
    formData.append('dateofbirth', this.form.value.dateofbirth);
    formData.append('phone', this.form.value.phone);

    var base64String!: string;
    if (this.selectedFile) {
      const reader = new FileReader();
      reader.onload = (event) => {
        base64String = reader.result as string;
      };
    }
    this.service
      .addCustomer(formData)

      .subscribe({
        next: (res) => {
          if (res.includes('Created')) {
            this.Message = 'New user created Successfully!';
            this.isAccountCreated = true;
            this.customers.push({
              name: this.form.value.name,
              email: this.form.value.email,
              password: this.form.value.password,
              city: this.form.value.city,
              country: this.form.value.country,
              address: this.form.value.address,
              dateofbirth: this.form.value.dateofbirth,
              phone: this.form.value.phone,
            });
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
}
