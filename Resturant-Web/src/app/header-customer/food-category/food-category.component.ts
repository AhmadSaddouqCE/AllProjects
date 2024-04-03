import { AfterViewChecked, Component, OnInit } from '@angular/core';
import { headerCustomerServices } from '../header-customer.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-food-category',
  templateUrl: './food-category.component.html',
  styleUrl: './food-category.component.css',
})
export class FoodCategoryComponent implements OnInit, AfterViewChecked {
  CategoriesList!: any;
  CategoryItems!: string;
  constructor(
    private headerCustomerService: headerCustomerServices,
    private route: ActivatedRoute,
    private router: Router
  ) {}
  ngOnInit(): void {
    this.getAllCategories();
  }
  ngAfterViewChecked(): void {}
  showCategoryProducts(categoryId: number) {
    localStorage.setItem('categoryId', categoryId.toString());
    this.router.navigateByUrl('/Menu');
  }
  getAllCategories() {
    this.headerCustomerService.getAllCategories().subscribe({
      next: (res) => {
        this.CategoriesList = res;
      },
      error: (error) => {
        console.log('No Categories Found');
      },
    });
  }
}
