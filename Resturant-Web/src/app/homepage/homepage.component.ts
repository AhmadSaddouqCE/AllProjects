import { Component, OnInit, ViewChild } from '@angular/core';
import { HomepageService } from './homepage.service';
import { ActivatedRoute, Router } from '@angular/router';
import { LoginComponent } from '../login/login.component';
import { LoginServices } from '../login/login.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { SideBarComponent } from '../header-customer/side-bar/side-bar.component';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.css'],
})
export class HomepageComponent implements OnInit {
  customers: any[] = [];
  Message = '';
  form1!: FormGroup;
  CheckEmpty = 'No Elements Found';

  ElementProdut: any[] = [];
  ElementCustomer: any[] = [];

  constructor(
    private homepageService: HomepageService,
    private route: ActivatedRoute,
    private router: Router,
    private loginService: LoginServices,
    private fb: FormBuilder
  ) {
    this.form1 = this.fb.group({
      name: [null, [Validators.required], []],
    });
  }

  ngOnInit(): void {
    this.getAllUsers();
    this.loginService.getMessage().subscribe((message) => {
      this.Message = message;
    });
  }
  Search() {
    this.ElementCustomer = [];
    this.ElementProdut = [];
    this.CheckEmpty = '';
    this.homepageService.getbySearch([this.form1.value.name]).subscribe({
      next: (res) => {
        res.forEach((item) => {
          if (item.customer) {
            this.ElementCustomer.push(item.customer);
          }
          if (item.product) {
            this.ElementProdut.push(item.product);
          }
        });
      },
      error: (error) => {
        if (error.status === 404) this.CheckEmpty = 'No Elements Found';
      },
    });
  }
  onInputChange(value: string) {
    this.Search();
  }
  getAllUsers(): void {
    this.homepageService.getAllUsers().subscribe({
      next: (data: any[]) => {
        this.customers = data;
      },
      error: (error) => {
        console.error('Error Fetching customers:', error);
      },
    });
  }
}
