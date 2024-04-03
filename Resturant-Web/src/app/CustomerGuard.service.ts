import { Injectable } from '@angular/core';
import {
  Router,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  UrlTree,
  CanActivate,
  CanActivateFn,
} from '@angular/router';
import { LoginServices } from './login/login.service';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CustomerAuthGuard implements CanActivate {
  constructor(private loginService: LoginServices, private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ):
    | boolean
    | UrlTree
    | Observable<boolean | UrlTree>
    | Promise<boolean | UrlTree> {
    if (this.loginService.isLoggedInCustomer()) {
      return true;
    } else {
      return this.router.parseUrl('/Customer-Login');
    }
  }
}
