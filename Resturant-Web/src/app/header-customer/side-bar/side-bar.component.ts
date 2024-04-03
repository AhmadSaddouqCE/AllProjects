import { AfterViewChecked, ChangeDetectorRef, Component, OnInit, Output } from '@angular/core';
import { headerCustomerServices } from '../header-customer.service';
import { ActivatedRoute, Router } from '@angular/router';
import { productService } from 'src/app/homepage/products/products.service';
import { jwtDecode } from 'jwt-decode';
import { customerOrderService } from 'src/app/customer/customerOrder.service';
import { DatePipe } from '@angular/common';
import { ToastrService } from 'ngx-toastr';
import { MatDialog } from '@angular/material/dialog';
import { NgbModal, NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { HeaderCustomerComponent } from '../header-customer.component';
import { error } from 'jquery';
import { ShoppingServices } from '../shopping-cart/Shopping.service';
import { EventEmitter } from '@angular/core';
import { BehaviorSubject, Observable, find } from 'rxjs';
declare var $: any;

@Component({
  selector: 'app-side-bar',
  templateUrl: './side-bar.component.html',
  styleUrls: ['./side-bar.component.css'],
})
export class SideBarComponent implements OnInit, AfterViewChecked {
  name!: string;
  token!: string;
  decodedToken!: any;
  customerData: any[] = [];
  Products: any[] = [];
  customerId!: string;
  CartItems: any[] = [];
  CheckNoData = 'No Orders Found';
  Order: Array<any> = [];
  catId!: string;
  private cartLengthSubject: BehaviorSubject<number> =
    new BehaviorSubject<number>(0);
  TotalPrice!: number;
  selectedOrderProducts!: any[];
  totalPagesList: any = [];
  categoryProducts: any[] = [];
  constructor(
    private toastr: ToastrService,
    private homepageCustomerService: headerCustomerServices,
    private route: ActivatedRoute,
    private router: Router,
    private addProductService: productService,
    private addOrderService: customerOrderService,
    private datePipe: DatePipe,
    private dialog: MatDialog,
    private modalService: NgbModal,
    private shoppingService: ShoppingServices,
    private cdr: ChangeDetectorRef
  ) {}
  ngAfterViewChecked(): void {
    this.totalPagesList = [];
    this.homepageCustomerService.setCartLength(this.CartItems.length);
    var lengthOfProductList = this.Products.length;
    let totalPages: number = Math.ceil(lengthOfProductList / 4);
    for (let i = 1; i <= totalPages; i++) {
      this.totalPagesList.push({
        pageNumber: i,
      });
    }
  }

  ngOnInit() {
    this.getAllProducts();
    this.getCustomerCart();
    this.getProductsInCategory();
    this.token =
      localStorage.getItem('token') ||
      'Looks Like there is an error with authintication';
    this.decodedToken = jwtDecode(this.token);
    this.name =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
      ];
    this.customerId =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId'
      ];
  }

  calculateProductTotalPrice() {
    this.customerData.forEach((order) => {
      order.totalPrice = order.products.reduce(
        (totalPrice: number, product: any) => totalPrice + product.totalPrice,
        0
      );
    });
  }
  calculateOrderTotalPrice() {
    this.TotalPrice = this.customerData.reduce(
      (total: number, item: { totalPrice: number }) => total + item.totalPrice,
      0
    );
  }
  getCustomerCart(): void {
    this.shoppingService.getCustomerCarts().subscribe({
      next: (data: any[]) => {
        this.CartItems = data;
      },
      error: (error) => {
        this.toastr.error('Error Fetching Cart', 'Error');
      },
    });
  }
  resetQuantity(product: any) {
    if (product.quantityCounter > product.quantity) {
      this.toastr.warning(
        'You have exceeded the available quantity',
        'Warning'
      );

      product.quantityCounter = '';
    }
    if (product.quantityCounter < 0) {
      this.toastr.warning('Invalid Quantity', 'Warning');
      product.quantityCounter = 1;
    }
  }

  addToCart(product: any, productName: string) {
    if (
      product.quantityCounter === 0 ||
      product.quantityCounter === undefined
    ) {
      this.toastr.warning('Please add a valid quantity', 'Warning');
      return;
    }
    let quantityToString = product.quantityCounter.toString();
    const formData = new FormData();
    formData.append('CustomerId', this.customerId);
    formData.append('ProductId', product.productId);
    formData.append('Quantity', quantityToString);
    formData.append('Price', product.price);
    formData.append('ImageUrl', product.imageUrl);
    this.homepageCustomerService.addToCart(formData).subscribe({
      next: (res) => {
        if (res.includes('New Cart Added Succefully')) {
          this.toastr.success('Added To Cart Succefully', 'Success');
          const index = this.categoryProducts.findIndex(
            (item) => item.productId === product.productId
          );
          if (index !== -1) {
            this.categoryProducts[index].quantity =
              parseInt(this.categoryProducts[index].quantity) -
              parseInt(quantityToString);

            product.quantityCounter = '';
            const findProductInCart = this.CartItems.findIndex(
              (items) => items.productId === product.productId
            );
            if (findProductInCart === -1) {
              this.getCustomerCart();
              this.homepageCustomerService.setCartLength(this.CartItems.length);
            }
          }
        }
      },
      error: (error) => {
        if (error.status === 500) {
          alert(error.error);
        }
      },
    });
  }
  formatOrderDate(orderDate: string): string {
    const parsedDate = new Date(orderDate);

    const formattedDate = this.datePipe.transform(
      parsedDate,
      'MMMM d, y, h:mm a'
    );

    return formattedDate || '';
  }
  goToCart() {
    this.router.navigateByUrl('/CustomerCart');
  }
  getTotalItemsInCart(): number {
    return this.CartItems.length;
  }
  getAllProducts(): void {
    this.addProductService.getAllProducts().subscribe({
      next: (data: any[]) => {
        this.Products = data;
      },
      error: (error) => {
        console.log('Error Fetching  products');
      },
    });
  }
  getProductsInCategory(): void {
    this.catId = localStorage.getItem('categoryId') || 'categoryIdNotFound';
    this.homepageCustomerService
      .getPrdouctsByCategoryId(this.catId.toString())
      .subscribe({
        next: (data: any[]) => {
          this.categoryProducts = data;
        },
        error: (error) => {
          console.log('Error Fetching  products');
        },
      });
  }
}
