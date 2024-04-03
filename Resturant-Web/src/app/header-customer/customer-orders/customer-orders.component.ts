import {
  AfterViewChecked,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { headerCustomerServices } from '../header-customer.service';
import { DatePipe } from '@angular/common';
import { MatDialog } from '@angular/material/dialog';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { productService } from 'src/app/homepage/products/products.service';
import { jwtDecode } from 'jwt-decode';
import { find } from 'rxjs';
declare var $: any;

@Component({
  selector: 'app-customer-orders',
  templateUrl: './customer-orders.component.html',
  styleUrl: './customer-orders.component.css',
})
export class CustomerOrdersComponent implements OnInit {
  selectedOrderProducts!: any[];
  TotalPrice!: number;
  customerData: any[] = [];
  Products: any[] = [];
  activeOrderId: number | null = null;
  selectedProductName!: string;
  selectedQuantity!: string;
  customerId!: string;
  token!: string;
  decodedToken!: any;
  customerName!: string;
  orderId!: string;
  findProdcutIndex!: number; // This is for setProductQuantity() Method
  addProducts!: any[];
  setQuantityBySelect: number = 0;
  addToProductList: any[] = [];
  numberOfItems!: number;
  displayProductsToDelete: any = [];

  @ViewChild('productquantity', { static: true })
  productquantity!: ElementRef<HTMLInputElement>;
  constructor(
    private homepageCustomerService: headerCustomerServices,
    private datePipe: DatePipe,
    private route: ActivatedRoute,
    private router: Router,
    private toastr: ToastrService,
    private modalService: NgbModal,
    private addProductService: productService
  ) {}
  ngOnInit(): void {
    this.getAllProducts();
    this.getUserOrder();
    this.token =
      localStorage.getItem('token') ||
      'Looks Like there is an error with authintication';
    this.decodedToken = jwtDecode(this.token);
    this.customerId =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId'
      ];
    this.customerName =
      this.decodedToken[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
      ];
  }

  toggleOrderDetails(order: any): void {
    this.homepageCustomerService.getOrdersById(order.orderId).subscribe({
      next: (res) => {
        if (res.length !== 0) {
          this.activeOrderId = order.orderId;
          order.showDetails = !order.showDetails;
        }
      },
      error: (error) => {
        this.toastr.error('No Orders Found', 'error');
      },
    });
  }

  resetQuantity(quantity: string) {
    if (parseInt(quantity) < 0) {
      this.toastr.warning('Invalid Quantity', 'Warning');
      this.productquantity.nativeElement.value = '0';
    }
  }
  openEditOrderModal(orderId: string) {
    this.orderId = orderId;
    this.selectedQuantity = '';
    this.selectedProductName = '';
    this.setQuantityBySelect = 0;
    $('#editOrderModal').modal('show');
  }
  DeleteProduct(orderId: string) {
    this.orderId = orderId;
    this.selectedQuantity = '';
    this.selectedProductName = '';
    this.setQuantityBySelect = 0;
    this.displayProductsToDelete = [];
    const findIndex = this.customerData.findIndex(
      (item) => item.orderId === this.orderId
    );
    if (findIndex !== -1) {
      this.customerData[findIndex].products.forEach((order: any) => {
        this.displayProductsToDelete.push({
          productName: order.productName,
        });
      });
    }
    $('#DeleteProductModal').modal('show');
  }
  CloseModel() {
    this.orderId = '';
    this.selectedQuantity = '';
    this.selectedProductName = '';
    this.setQuantityBySelect = 0;
  }
  getUserOrder(): void {
    this.homepageCustomerService.getCustomerOrderList().subscribe({
      next: (data: any[]) => {
        const uniqueOrders = new Map();

        data.forEach((order) => {
          if (!uniqueOrders.has(order.orderId)) {
            uniqueOrders.set(order.orderId, { ...order, products: [] });
          }
          uniqueOrders.get(order.orderId).products.push(order);
        });

        const filteredData = Array.from(uniqueOrders.values());
        this.customerData = filteredData.map((customerdata) => ({
          ...customerdata,
          orderDate: this.formatOrderDate(customerdata.orderDate),
        }));
        this.calculateProductTotalPrice();
        this.calculateOrderTotalPrice();
        this.customerData.forEach((items) => {
          items.numberOfItems = items.products.length;
        });
      },
      error: (error) => {
        this.toastr.error('No Orders Found', 'Error');
      },
    });
  }
  DeleteProductFromOrder() {
    const findProdcutIndex = this.Products.findIndex(
      (item) => item.name === this.selectedProductName
    );
    if (findProdcutIndex !== -1) {
      let productId = this.Products[findProdcutIndex].productId;
      const formData = new FormData();
      formData.append('orderId', this.orderId);
      formData.append('productId', productId);
      this.homepageCustomerService.DeleteProductFromOrder(formData).subscribe({
        next: (res) => {
          if (res.includes('Deleted Succefully')) {
            const findOrderIndex = this.customerData.findIndex(
              (item) => item.orderId === this.orderId
            );
            if (findOrderIndex !== -1) {
              const productIndex = this.customerData[
                findOrderIndex
              ].products.findIndex(
                (product: any) => product.productId === productId
              );
              if (productIndex !== -1) {
                this.Products[findProdcutIndex].quantity +=
                  this.customerData[findOrderIndex].products[
                    productIndex
                  ].quantitiy;

                this.customerData[findOrderIndex].products.splice(
                  productIndex,
                  1
                );
                this.calculateProductTotalPrice();
                this.calculateOrderTotalPrice();
                const findProductLength =
                  this.customerData[findOrderIndex].products.length;
                if (findProductLength === 0) {
                  this.customerData.splice(findOrderIndex, 1);
                }
                this.customerData.forEach((items) => {
                  items.numberOfItems = items.products.length;
                });
                this.toastr.success(
                  `${this.selectedProductName} Is Deleted From The Order`,
                  'Success'
                );
                const indexToRemove = this.displayProductsToDelete.findIndex(
                  (item: any) => item.productName === this.selectedProductName
                );
                if (indexToRemove !== -1) {
                  this.displayProductsToDelete.splice(indexToRemove, 1);
                }
              }
            }
            this.selectedProductName = '';
          }
        },
        error: (error) => {
          this.toastr.error("This Product Doesn't Exist", 'error');
        },
      });
    }
  }
  public async modifyProductToList() {
    if (
      parseInt(this.selectedQuantity) <= 0 ||
      /[a-zA-Z]/.test(this.selectedQuantity)
    ) {
      this.toastr.warning('Invalid Quantity', 'Warning');
      this.productquantity.nativeElement.value = '0';
    } else {
      let Id = this.Products[this.findProdcutIndex].productId;
      const formData = new FormData();
      formData.append('selectedQuantity', this.selectedQuantity);
      formData.append('productId', Id);
      formData.append('orderId', this.orderId);
      this.homepageCustomerService.modifyProductToList(formData).subscribe({
        next: (res) => {
          if (res.includes('New Product Added To Cart')) {
            const insertProductIndex = this.customerData.findIndex(
              (item) => item.orderId === this.orderId
            );
            const productOrderIndex = this.customerData[
              insertProductIndex
            ].products.findIndex(
              (item: any) => item.productName === this.selectedProductName
            );

            if (productOrderIndex !== -1) {
              let oldQuantity =
                this.customerData[insertProductIndex].products[
                  productOrderIndex
                ].quantitiy;
              let price =
                this.customerData[insertProductIndex].products[
                  productOrderIndex
                ].price;
              this.customerData[insertProductIndex].products[
                productOrderIndex
              ].quantitiy = this.selectedQuantity;
              this.customerData[insertProductIndex].products[
                productOrderIndex
              ].totalPrice = parseInt(this.selectedQuantity) * price;
              const findProductIndex = this.Products.findIndex(
                (item) => item.name == this.selectedProductName
              );
              if (findProductIndex !== -1) {
                let newTotalQuantity =
                  this.Products[findProductIndex].quantity +
                  oldQuantity -
                  parseInt(this.selectedQuantity);
                this.setQuantityBySelect = newTotalQuantity;
                this.Products[findProductIndex].quantity =
                  this.setQuantityBySelect;

                this.toastr.success('Quantity Edited Successfully', 'Success');
                this.selectedQuantity = '';
                this.selectedProductName = '';
                this.setQuantityBySelect = 0;
              }
            } else {
              const getProduct = this.Products.find(
                (item) => item.name === this.selectedProductName
              );
              if (getProduct) {
                let getOrderDate =
                  this.customerData[insertProductIndex].products[0].orderDate;
                let getProductPrice = getProduct.price;
                let getProductId = getProduct.productId;
                this.customerData[insertProductIndex].products.push({
                  customerId: this.customerId,
                  customerName: this.customerName,
                  orderDate: getOrderDate,
                  orderId: this.orderId,
                  orderStatus: 'Pending',
                  productId: getProductId,
                  price: getProductPrice,
                  productName: this.selectedProductName,
                  quantitiy: this.selectedQuantity,
                  totalPrice: parseInt(this.selectedQuantity) * getProductPrice,
                });
                this.toastr.success(
                  `${this.selectedProductName} Is Added To Your Order`,
                  'Success'
                );
                const findIndexToEditQuantityAfterAdd = this.Products.findIndex(
                  (item) => item.name === this.selectedProductName
                );
                this.Products[findIndexToEditQuantityAfterAdd].quantity -=
                  parseInt(this.selectedQuantity);
                this.customerData.forEach((items) => {
                  items.numberOfItems = items.products.length;
                });
              }
            }
            this.selectedQuantity = '';
            this.selectedProductName = '';
            this.setQuantityBySelect = 0;
            this.calculateProductTotalPrice();
            this.calculateOrderTotalPrice();
          }
        },

        error: (error) => {
          this.toastr.error(error.error, 'Error');
          this.selectedQuantity = '';
          this.selectedProductName = '';
        },
      });
    }
  }

  setProductQuantity(): number {
    this.addToProductList = [];
    this.findProdcutIndex = this.Products.findIndex(
      (item) => item.name === this.selectedProductName
    );
    if (this.findProdcutIndex !== -1) {
      this.setQuantityBySelect = this.Products[this.findProdcutIndex].quantity;
      const findOrderIndex = this.customerData.findIndex(
        (item) => item.orderId === this.orderId
      );

      if (findOrderIndex !== -1) {
        const indexQuantity = this.customerData[
          findOrderIndex
        ].products.findIndex(
          (name: any) => name.productName === this.selectedProductName
        );

        if (indexQuantity !== -1) {
          this.selectedQuantity =
            this.customerData[findOrderIndex].products[indexQuantity].quantitiy;
        } else {
          this.selectedQuantity = '';
        }
      }
    } else {
      this.selectedQuantity = '';
    }
    return this.findProdcutIndex;
  }
  productExistsInOrder(productName: string): boolean {
    const orderIndex = this.customerData.findIndex(
      (item) => item.orderId === this.orderId
    );
    if (orderIndex !== -1) {
      const order = this.customerData[orderIndex];
      return order.products.some(
        (product: any) =>
          product.productName === productName && product.categoryId !== null
      );
    }

    return false;
  }

  DeleteOrder(orderId: number) {
    this.homepageCustomerService.deleteOrder(orderId).subscribe({
      next: (res) => {
        if (res.includes('Deleted Succefully')) {
          this.toastr.success(' Order Deleted Successfully', 'Success');
          const order = this.customerData.find((o) => o.orderId === orderId);
          if (order) {
            order.products.forEach((product: any) => {
              const productIndex = this.Products.findIndex(
                (p) => p.productId === product.productId
              );
              if (productIndex !== -1) {
                this.Products[productIndex].quantity += product.quantitiy;
              }
            });
          }
          const index = this.customerData.findIndex(
            (item) => item.orderId === orderId
          );
          if (index !== -1) {
            this.customerData.splice(index, 1);
            this.calculateOrderTotalPrice();
          }
        }
      },
    });
  }
  getAllProducts(): void {
    this.addProductService.getAllProducts().subscribe({
      next: (data: any[]) => {
        this.Products = data;
      },
      error: (error) => {
        console.log('No Products Found');
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
}
