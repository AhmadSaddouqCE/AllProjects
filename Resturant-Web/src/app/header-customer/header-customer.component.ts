import { Component, Input, OnInit } from '@angular/core';
import { jwtDecode } from 'jwt-decode';
import { headerCustomerServices } from './header-customer.service';
import { ActivatedRoute, Router } from '@angular/router';
import { productService } from '../homepage/products/products.service';
import { ToastrService } from 'ngx-toastr';
import { ShoppingServices } from './shopping-cart/Shopping.service';
import { Subscription } from 'rxjs';
import { CartCustomerService } from '../customer/CartCustomer.service';
import { SideBarComponent } from './side-bar/side-bar.component';
@Component({
  selector: 'app-header-customer',
  templateUrl: './header-customer.component.html',
  styleUrls: ['./header-customer.component.css'],
})
export class HeaderCustomerComponent implements OnInit {
  name!: string;
  cartSubscription: Subscription | undefined;
  totalItemsInCart: number = 0;
  token!: string;
  decodedToken!: any;
  customerData: any = [];
  Products: any[] = [];
  CartItems: any[] = [];
  CheckNoData = 'No Orders Found';
  numberOfCartItems!:number
  constructor(
    private homepageCustomerService: headerCustomerServices,
    private route: ActivatedRoute,
    private router: Router,
    private toastr: ToastrService,
    private addProductService: productService,
    private shoppingService: ShoppingServices,
    private cartService: CartCustomerService,

  ) {}
  ngOnInit() {
    this.getCustomerCart();
    this.homepageCustomerService.getCartLength().subscribe(length => {
      this.numberOfCartItems = length;
    });
    this.token =
      localStorage.getItem('token') ||
      'Looks Like there is an error with authintication';
    this.decodedToken = jwtDecode(this.token);
    this.name =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
      ];
  }
  goToCart(){
    this.router.navigateByUrl('/CustomerCart')
  }
  getTotalItemsInCart(): number {
    return this.CartItems.length;
  }
  getCustomerCart(): void {
    this.shoppingService.getCustomerCarts().subscribe({
      next: (data: any[]) => {
        this.CartItems = data;
        this.totalItemsInCart = this.CartItems.length;
      },
      error: (error) => {
        this.toastr.error('Error Fetching Cart', 'Error');
      },
    });
  }
}
