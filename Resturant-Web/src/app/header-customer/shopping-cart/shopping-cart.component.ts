import {
  AfterViewChecked,
  AfterViewInit,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { ShoppingServices } from './Shopping.service';
import { ActivatedRoute, Route, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { of } from 'rxjs';
import { error } from 'jquery';
import { HeaderCustomerComponent } from '../header-customer.component';
import { CartCustomerService } from 'src/app/customer/CartCustomer.service';
import { productService } from 'src/app/homepage/products/products.service';
import { headerCustomerServices } from '../header-customer.service';
@Component({
  selector: 'app-shopping-cart',
  templateUrl: './shopping-cart.component.html',
  styleUrls: ['./shopping-cart.component.css'],
})
export class ShoppingCartComponent implements OnInit, AfterViewChecked {
  CartItems: any[] = [];
  @ViewChild('productquantity', { static: true })
  productquantity!: ElementRef<HTMLInputElement>;
  TotalPrice!: number;
  selectedCartId!: number | string;
  sendCart: any[] = [];
  Products: any[] = [];

  constructor(
    private toastr: ToastrService,
    private shoppingService: ShoppingServices,
    private router: Router,
    private currentRoute: ActivatedRoute,
    private addProductService: productService,
    private homepageCustomerService:headerCustomerServices

  ) {}
  ngAfterViewChecked(): void {
    this.homepageCustomerService.setCartLength(this.CartItems.length);
  }
  ngOnInit() {
    this.getCustomerCart();
  }

  setCartId_Quantity(cartid: number, quantity: number) {
    this.productquantity.nativeElement.valueAsNumber = quantity;
    this.selectedCartId = cartid;
  }

  resetQuantity(quantity: string) {
    if (parseInt(quantity) < 0) {
      this.toastr.warning('Invalid Quantity', 'Warning');
      this.productquantity.nativeElement.value = '0';
    }
  }
  getAllProducts(): void {
    this.addProductService.getAllProducts().subscribe({
      next: (data: any[]) => {
        this.Products = data;
      },
      error: (error) => {
        this.toastr.error('Error Fetching  products', 'Error');
      },
    });
  }
  addOrder() {
    this.shoppingService.addOrder().subscribe({
      next: (res) => {
        if (res.includes('Order Added Succefully')) {
          this.toastr.success('Order Added Succefully', 'Success');
          this.CartItems = [];
        }
      },
      error: (error) => {
        this.toastr.warning(error.error, 'Warning');
      },
    });
  }
  editQuantity() {
    if (this.selectedCartId !== undefined) {
      const quantity = this.productquantity.nativeElement?.value;
      const form = new FormData();
      let cartIdToString = this.selectedCartId.toString();
      let quantityToString = quantity;
      form.append('cartId', cartIdToString);
      form.append('quantity', quantityToString);
      this.shoppingService.editCustomerCartQuantity(form).subscribe({
        next: (res) => {
          if (res.includes('Edited Succefully')) {
            this.toastr.success('Edited Succefully', 'Success');
            const index = this.CartItems.findIndex(
              (item) => item.cartid === this.selectedCartId
            );
            if (index !== -1) {
              this.CartItems[index].quantity = quantity;
              this.CartItems[index].totalPrice =
                parseInt(quantity) * this.CartItems[index].price;
              this.TotalPrice = this.CartItems.reduce(
                (total: number, item: { quantity: number; price: number }) =>
                  total + item.quantity * item.price,
                0
              );
              this.productquantity.nativeElement.value = '0';
            }
          }
        },
        error: (error) => {
          if (error.status === 500) {
            this.productquantity.nativeElement.value = '0';
            this.toastr.warning(error.error, 'Warning');
          }
        },
      });
    }
  }

  deleteFromCart(cartId: number, productName:string) {
    this.shoppingService.deleteCustomerCart(cartId).subscribe({
      next: (res) => {
        if (res.includes('Deleted Succefully')) {
          this.toastr.success('Deleted Succefully', 'Success');
          const index = this.CartItems.findIndex(
            (item) => item.cartid === cartId
          );
          if (index !== -1) {
            this.CartItems.splice(index, 1);
            const findProductInCart = this.CartItems.findIndex(
              (item) => item.productName === productName
            );
            if (findProductInCart !== -1) {
              this.CartItems.length -= 1;
              this.homepageCustomerService.setCartLength(this.CartItems.length);
            }
            this.calculateCartTotalPrice();
          }
        }
      },
      error: (error) => {
        if (error.status === 500) {
          this.toastr.error(error.error, 'Error');
        }
      },
    });
  }
  getCustomerCart(): void {
    this.shoppingService.getCustomerCarts().subscribe({
      next: (data: any[]) => {
        this.CartItems = data;
        this.calculateCartTotalPrice();
      },
      error: (error) => {
        this.toastr.error('Error Fetching Cart', 'Error');
      },
    });
  }
  calculateCartTotalPrice() {
    this.TotalPrice = this.CartItems.reduce(
      (total, item) => total + item.totalPrice,
      0
    );
  }
}
