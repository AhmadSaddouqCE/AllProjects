import { Component, ElementRef, EventEmitter, OnInit, Output, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { productService } from '../products.service';
import { ToastrService } from 'ngx-toastr';
import { headerCustomerServices } from 'src/app/header-customer/header-customer.service';

@Component({
  selector: 'app-add-product',
  templateUrl: './add-product.component.html',
  styleUrls: ['./add-product.component.css'],
})
export class AddProductComponent implements OnInit {
  @Output() productsListChanged: EventEmitter<any[]> = new EventEmitter<any[]>();
  isAccountCreated: boolean = false;
  alert = true;
  form!: FormGroup;
  Message = '';
  selectedFile!: File;
  base64String!: string;
  Products: any[] = [];
  Categories: any[] = [];
  categoryId!: string;
  @ViewChild('nameInput', { static: true })
  nameInput!: ElementRef<HTMLInputElement>;
  @ViewChild('quantityInput', { static: true })
  quantityInput!: ElementRef<HTMLInputElement>;
  @ViewChild('priceInput', { static: true })
  priceInput!: ElementRef<HTMLInputElement>;
  @ViewChild('descriptionInput', { static: true })
  descriptionInput!: ElementRef<HTMLInputElement>;
  @ViewChild('myFileInput', { static: true })
  myFileInput!: ElementRef<HTMLInputElement>;
  selectedCategoryName!: string;
  constructor(
    private router: Router,
    private fb: FormBuilder,
    private addProductService: productService,
    private currentRoute: ActivatedRoute,
    private toastr: ToastrService,
    private headerCustomerService: headerCustomerServices
  ) {
    this.form = this.fb.group({
      name: [null, [Validators.required], []],
      description: [null, [Validators.required], []],
      price: [null, [Validators.required], []],
      quantity: [null, [Validators.required], []],
      categoryName: [null, [Validators.required], []],
    });
  }
  ngOnInit(): void {
    this.getAllCategories();
  }
  Check(name: string, price: string, quantity: string, descrption: string) {
    if (name !== '' && price !== '' && quantity !== '' && descrption !== '') {
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
  getAllCategories() {
    this.headerCustomerService.getAllCategories().subscribe({
      next: (res) => {
        this.Categories = res;
      },
      error: (error) => {
        console.log('No Categories Found');
      },
    });
  }
  resetData() {
    this.Message = ''
    this.isAccountCreated = false
    this.nameInput.nativeElement.value = '';
    this.priceInput.nativeElement.value = '';
    this.descriptionInput.nativeElement.value = '';
    this.quantityInput.nativeElement.value = '';
    this.selectedCategoryName = '';
    this.myFileInput.nativeElement.value = '';
  }
  public submitForm() {
    let checkCategoryName = this.form.value.categoryName;
    const findCategoryIndex = this.Categories.findIndex(
      (item) => item.categoryName === checkCategoryName
    );
    if (findCategoryIndex !== -1) {
      this.categoryId = this.Categories[findCategoryIndex].categoryId;
      if (this.selectedFile) {
        const formData = new FormData();
        formData.append('Name', this.form.value.name);
        formData.append('Price', this.form.value.price);
        formData.append('Quantity', this.form.value.quantity);
        formData.append('Description',this.form.value.description);
        formData.append('categoryId', this.categoryId);
        formData.append('ProductImage', this.selectedFile);
        this.addProductService
          .addProduct(formData)
          .subscribe({
            next: (res: any) => {
              const message = res.message;
              const productData = res.products;
              if(message === "New Product Is Created Successfully"){
                this.Message = 'New Product created Successfully!';
                this.isAccountCreated = true;
                this.productsListChanged.emit(productData);
              }
              
            },
            error: (error) => {
              if (
                error.status === 500 &&
                error.error.includes('This Product already exists')
              ) {
                this.Message = 'Product Already Exists';
                this.isAccountCreated = false;
                this.resetData();
              }
            },
          });
      } else {
        this.toastr.error('No File Selected', 'Error');
      }
    } else {
      this.toastr.error("Category Doesn't Exist", 'Error');
      this.nameInput.nativeElement.value = '';
      this.resetData();
    }
  }
}
