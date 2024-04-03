import { NgModule } from '@angular/core';
import { RouterModule, Routes, CanActivate } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { SignUpComponent } from './sign-up/sign-up.component';
import { HomepageComponent } from './homepage/homepage.component';
import { AddUserComponent } from './homepage/add-user/add-user.component';
import { EditUserComponent } from './homepage/edit-user/edit-user.component';
import { ProductsComponent } from './homepage/products/products.component';
import { NotFoundComponent } from './not-found/not-found.component';
import { AuthGuard } from './AuthGuard.service';
import { OrderComponent } from './homepage/order/order.component';
import { CustomerLoginComponent } from './customer/customer-login/customer-login.component';
import { CustomerSignupComponent } from './customer/customer-signup/customer-signup.component';
import { CustomerComponent } from './customer/customer.component';
import { ShoppingCartComponent } from './header-customer/shopping-cart/shopping-cart.component';
import { SideBarComponent } from './header-customer/side-bar/side-bar.component';
import { SettingsComponent } from './header-customer/settings/settings.component';
import { CustomerOrdersComponent } from './header-customer/customer-orders/customer-orders.component';
import { CustomerAuthGuard } from './CustomerGuard.service';
import { FoodCategoryComponent } from './header-customer/food-category/food-category.component';
import { AddCategoryComponent } from './homepage/categories/add-category/add-category.component';
import { CategoriesComponent } from './homepage/categories/categories.component';
import { TestFileComponent } from './test-file/test-file.component';
import { TestFile2Component } from './test-file-2/test-file-2.component';
import { TestFile3Component } from './test-file-3/test-file-3.component';

const appRoutes: Routes = [
  { path: '', redirectTo: '/Customer-Login', pathMatch: 'full' },
  { path: 'TestFile3', component:TestFile3Component },
  { path: 'Customer-Login', component: CustomerLoginComponent },
  { path: 'TestFile', component: TestFile2Component},
  { path: 'Customer-SignUp', component: CustomerSignupComponent },
  { path: 'Dashboard', component: FoodCategoryComponent },
  {
    path: 'Customer-Homepage',
    component: CustomerComponent,
    canActivate: [CustomerAuthGuard],
  },
  { path: 'Admin-Login', component: LoginComponent },
  { path: 'Signup', component: SignUpComponent },
  { path: 'addUser', component: AddUserComponent, canActivate: [AuthGuard] },
  { path: 'editUser', component: EditUserComponent, canActivate: [AuthGuard] },
  { path: 'ShowProduts', component: ProductsComponent,canActivate: [AuthGuard] },
  { path: 'addOrder', component: OrderComponent, canActivate: [AuthGuard] },
  { path: 'showCategory', component: CategoriesComponent,canActivate: [AuthGuard] },
  { path: 'Homepage', component: HomepageComponent,canActivate: [AuthGuard] },
  {
    path: 'Menu',
    component: SideBarComponent,
    canActivate: [CustomerAuthGuard],
  },
  {
    path: 'CustomerCart',
    component: ShoppingCartComponent,
    canActivate: [CustomerAuthGuard],
  },
  {
    path: 'Settings-Customer',
    component: SettingsComponent,
    canActivate: [CustomerAuthGuard],
  },
  { path: 'CustomerOrders', component: CustomerOrdersComponent },
  { path: 'not-found', component: NotFoundComponent },
  { path: '**', redirectTo: '/not-found' },
];
@NgModule({
  imports: [RouterModule.forRoot(appRoutes)],
  exports: [RouterModule],
  providers: [AuthGuard, CustomerAuthGuard],
})
export class AppRoutingModule {}
