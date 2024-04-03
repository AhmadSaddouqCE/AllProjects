import {
  AfterViewChecked,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { productService } from './products.service';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { headerCustomerServices } from 'src/app/header-customer/header-customer.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.css'],
})
export class ProductsComponent implements OnInit {
  products: any[] = [];
  Message = '';
  form!: FormGroup;
  productName = '';
  Quantity = '';
  Price = '';
  Description = '';
  CategoryChosen = '';
  productId!: string;
  isAccountCreated: boolean = false;
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
  selectedFile!: File;
  alert = true;
  selectedCategoryName!: string;
  Categories: any[] = [];
  categoryId!: string;
  constructor(
    private productService: productService,
    private route: ActivatedRoute,
    private router: Router,
    private toastr: ToastrService,
    private fb: FormBuilder,
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
  ngOnInit() {
    this.getAllProducts();
    this.getAllCategories();
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
  openEditModal(products: any) {
    this.myFileInput.nativeElement.value = ''
    this.Message = '';
    this.isAccountCreated = false;
    this.productName = this.form.get('name')?.setValue(products.name) ?? '';
    this.Quantity =
      this.form.get('quantity')?.setValue(products.quantity) ?? '';
    this.Price = this.form.get('price')?.setValue(products.price) ?? '';
    const findProductInCategory = this.Categories.findIndex(
      (item) => item.categoryId == products.categoryId
    );
    if (findProductInCategory !== -1) {
      this.form
        .get('categoryName')
        ?.setValue(this.Categories[findProductInCategory].categoryName) ?? '';
    }
    this.Description =
      this.form.get('description')?.setValue(products.description) ?? '';
    this.productId = products.productId;
  }
  Check(name: string, price: string, quantity: string, descrption: string) {
    if (name !== '' && price !== '' && quantity !== '' && descrption !== '') {
      this.alert = true;
      return true;
    }
    this.Message = 'Please Fill All The Fields';
    this.isAccountCreated = false;
    return false;
  }
  updateProductsList(Data: any[]) {
    this.products.push(Data);
  }
  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }
  getAllProducts(): void {
    this.productService.getProducts().subscribe({
      next: (data: any[]) => {
        this.products = data;
      },
      error: (error) => {
        console.log('Error Fetching Products', 'Error');
      },
    });
  }
  deleteProduct(productId: string) {
    this.productService.deleteProduct(productId).subscribe({
      next: (res) => {
        if (res.includes('Product Deleted Succefully')) {
          const findIndex = this.products.findIndex(
            (item) => item.productId === productId
          );
          if (findIndex !== -1) {
            this.products.splice(findIndex, 1);
            this.toastr.success('Deleted Successfully', 'Success');
          }
        }
      },
      error: (error) => {
        this.toastr.error("Couldn't Delete the Product", 'Failed');
      },
    });
  }
  editForm() {
    const categoryIndex = this.Categories.findIndex(
      (item) => item.categoryName === this.form.value.categoryName
    );
    this.categoryId = this.Categories[categoryIndex].categoryId;
    const formData = new FormData();
    formData.append('Id', this.productId);
    formData.append('name', this.form.value.name);
    formData.append('quantity', this.form.value.quantity);
    formData.append('Description', this.form.value.description);
    formData.append('price', this.form.value.price);
    formData.append('categoryId', this.categoryId);
    formData.append('ProductImage', this.selectedFile);
    this.productService.editProduct(formData).subscribe({
      next: (res) => {
        if (res.includes('Product Updated Succefully')) {
          const productIndex = this.products.findIndex(
            (item) => item.productId === this.productId
          );
          if (productIndex !== -1) {
            this.Message = 'Product Updated Succefully';
            this.isAccountCreated = true;
            this.products[productIndex].name = this.form.value.name;
            this.products[productIndex].quantity = this.form.value.quantity;
            this.products[productIndex].price = this.form.value.price;
            this.products[productIndex].description =
              this.form.value.description;
            this.products[productIndex].categoryId = this.categoryId;
          }
        }
      },
      error: (error) => {
        this.Message = error.error;
        this.isAccountCreated = false;
      },
    });
  }
}
