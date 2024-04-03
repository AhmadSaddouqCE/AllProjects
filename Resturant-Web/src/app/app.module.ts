import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { MatFormFieldModule } from '@angular/material/form-field';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { SignUpComponent } from './sign-up/sign-up.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AppRoutingModule } from './app.routing.module';
import { HttpClientModule } from '@angular/common/http';
import { SignupService } from './sign-up/sign-up.service';
import { GlobalEnvironment } from './environment';
import { HeaderComponent } from './header/header.component';
import { HomepageComponent } from './homepage/homepage.component';
import { AddUserComponent } from './homepage/add-user/add-user.component';
import { EditUserComponent } from './homepage/edit-user/edit-user.component';
import { LoginServices } from './login/login.service';
import { EditUserService } from './homepage/edit-user/edit.user.service';
import { ProductsComponent } from './homepage/products/products.component';
import { NotFoundComponent } from './not-found/not-found.component';
import { OrderComponent } from './homepage/order/order.component';
import { CustomerComponent } from './customer/customer.component';
import { CustomerLoginComponent } from './customer/customer-login/customer-login.component';
import { CustomerSignupComponent } from './customer/customer-signup/customer-signup.component';
import { HeaderCustomerComponent } from './header-customer/header-customer.component';
import { AddProductComponent } from './homepage/products/add-product/add-product.component';
import { SideBarComponent } from './header-customer/side-bar/side-bar.component';
import { DatePipe } from '@angular/common';
import { ShoppingCartComponent } from './header-customer/shopping-cart/shopping-cart.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';
import { NgbModalModule } from '@ng-bootstrap/ng-bootstrap';
import { SettingsComponent } from './header-customer/settings/settings.component';
import { CustomerOrdersComponent } from './header-customer/customer-orders/customer-orders.component';
import { MatOptionModule } from '@angular/material/core';
import { FoodCategoryComponent } from './header-customer/food-category/food-category.component';
import { AddCategoryComponent } from './homepage/categories/add-category/add-category.component';
import { CategoriesComponent } from './homepage/categories/categories.component';
import { CategoryService } from './homepage/categories/categories.service';
import { TestFileComponent } from './test-file/test-file.component';
import { TestFile2Component } from './test-file-2/test-file-2.component';
import { TestFile3Component } from './test-file-3/test-file-3.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignUpComponent,
    HeaderComponent,
    HomepageComponent,
    AddUserComponent,
    EditUserComponent,
    ProductsComponent,
    NotFoundComponent,
    OrderComponent,
    CustomerComponent,
    CustomerLoginComponent,
    CustomerSignupComponent,
    HeaderCustomerComponent,
    AddProductComponent,
    SideBarComponent,
    ShoppingCartComponent,
    SettingsComponent,
    CustomerOrdersComponent,
    FoodCategoryComponent,
    CategoriesComponent,
    AddCategoryComponent,
    TestFileComponent,
    TestFile2Component,
    TestFile3Component
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    ToastrModule.forRoot(),
    NgbModalModule,
    MatFormFieldModule,
    MatOptionModule,
    AppRoutingModule
  ],
  providers: [
    SignupService,
    GlobalEnvironment,
    LoginServices,
    EditUserService,
    DatePipe,
    CategoryService
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
