import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { headerCustomerServices } from 'src/app/header-customer/header-customer.service';
import { CategoryService } from './categories.service';
import { ToastrService } from 'ngx-toastr';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrl: './categories.component.css',
})
export class CategoriesComponent implements OnInit {
  Categories: any[] = [];
  selectedFile!: File;
  name = '';
  Message = '';
  form!: FormGroup;
  isAccountCreated = false;
  categoryId!: string;
  @ViewChild('nameInput', { static: true })
  nameInput!: ElementRef<HTMLInputElement>;
  @ViewChild('myFileInput', { static: true })
  myFileInput!: ElementRef<HTMLInputElement>;
  constructor(
    private headerCustomerService: headerCustomerServices,
    private categoryService: CategoryService,
    private toastr: ToastrService,
    private fb: FormBuilder
  ) {
    this.form = fb.group({
      name: [null, [Validators.required], []],
    });
  }
  ngOnInit(): void {
    this.getAllCategories();
  }
  openEditModalCategory(category: any) {
    this.myFileInput.nativeElement.value = ''
    this.name = this.form.get('name')?.setValue(category.categoryName) ?? '';
    this.categoryId = category.categoryId;
    this.Message = '';
    this.isAccountCreated = false;
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
  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }
  Check(name: string) {
    if (name === '') {
      this.Message = 'Fill Fill The Fields';
      this.isAccountCreated = false;
    }
  }
  deleteCategory(categoryId: string) {
    this.categoryService.deleteCategory(categoryId).subscribe({
      next: (res) => {
        console.log(res);
        if (res.includes('Category Deleted Succefully')) {
          const findIndex = this.Categories.findIndex(
            (item) => item.categoryId === categoryId
          );
          if (findIndex !== -1) {
            this.Categories.splice(findIndex, 1);
            this.toastr.success('Deleted Successfully', 'Success');
          }
        }
      },
      error: (error) => {
        this.toastr.error("Couldn't Delete The Category", 'Failed');
      },
    });
  }
  editCategoryForm() {
    const formData = new FormData();
    formData.append('categoryId', this.categoryId);
    formData.append('categoryName', this.form.value.name);
    formData.append('categoryImage', this.selectedFile);
    this.categoryService.modifyCategory(formData).subscribe({
      next: (res) => {
        if (res.includes('Category Updated Succefully')) {
          const categoryIndex = this.Categories.findIndex(
            (item) => item.categoryId === this.categoryId
          );
          if (categoryIndex !== -1) {
            this.Message = 'Category Updated Succefully';
            this.isAccountCreated = true;
            this.Categories[categoryIndex].categoryName = this.form.value.name;
          }
        }
      },
      error: (error) => {
        this.Message = error.error;
        this.isAccountCreated = false;
      },
    });
  }
  updateCategoryList(Data: any[]) {
    this.Categories.push(Data);
  }
}
