import { Component, ElementRef, EventEmitter, OnInit, Output, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { CategoryService } from '../categories.service';

@Component({
  selector: 'app-add-category',
  templateUrl: './add-category.component.html',
  styleUrl: './add-category.component.css',
})
export class AddCategoryComponent implements OnInit {
  form!: FormGroup;
  alert = true;
  selectedFile!: File;
  Message = '';
  isAccountCreated: boolean = false;
  @ViewChild('nameInput', { static: true })
  nameInput!: ElementRef<HTMLInputElement>;
  @ViewChild('myFileInput', { static: true })
  myFileInput!: ElementRef<HTMLInputElement>;
  @Output() categoryListChanged: EventEmitter<any[]> = new EventEmitter<any[]>();

  constructor(
    private fb: FormBuilder,
    private toastr: ToastrService,
    private addCategoryService: CategoryService
  ) {}
  ngOnInit(): void {
    this.form = this.fb.group({
      name: [null, [Validators.required], []],
    });
  }
  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }
  Check(name: string) {
    if (name !== '') {
      this.alert = true;
      return true;
    }
    this.Message = 'Please Fill All The Fields ';
    return false;
  }
  resetData() {
    this.Message = ''
    this.isAccountCreated = false
    this.nameInput.nativeElement.value = '';
    this.myFileInput.nativeElement.value = '';
  }
  public submitForm() {
    if (this.selectedFile) {
      const formData = new FormData()
      formData.append("categoryName", this.form.value.name)
      formData.append("categoryImage", this.selectedFile)
      this.addCategoryService
        .addCategory(formData)
        .subscribe({
          next: (res: any) => {
            const message = res.message
            const categoryData = res.category
            if (message === "New Category Added") {
              this.Message = 'New Category created Successfully!';
              this.isAccountCreated = true;
              this.categoryListChanged.emit(categoryData)
            }
          },
          error: (error) => {
            if (
              error.status === 500 &&
              error.error.includes('This Category Name Does Exist')
            ) {
              this.Message = 'Category Already Exists';
              this.isAccountCreated = false;
              this.resetData();
            }
          },
        });
    } else {
      this.toastr.error('No File Selected', 'Error');
    }
  }
}
