import { AfterViewChecked, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { faAdd, faE, faEdit, faTrash } from '@fortawesome/free-solid-svg-icons';
import { lookupsService } from './lookups.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-lookups-list',
  templateUrl: './lookups-list.component.html',
  styleUrl: './lookups-list.component.css',
})
export class LookupsListComponent implements OnInit {
  isSidebarExpanded = false;
  icon = faAdd;
  modify = faEdit;
  delete = faTrash;
  selectedCategory!: string;
  form!: FormGroup;
  categoriesList: any[] = [];
  items: any[] = [];
  Lookupslist: any[] = [];
  setCategoryName!: string;
  constructor(
    private fb: FormBuilder,
    private lookupsService: lookupsService,
    private toastr: ToastrService
  ) {
    this.form = this.fb.group({
      code: [null, [Validators.required], []],
      nameen: [null, [Validators.required], []],
      namear: [null, [Validators.required], []],
    });
  }
  ngOnInit(): void {
    this.getCategories();
    this.loadMoreItems();
  }
  loadMoreItems() {
    for (let i = 0; i < 10; i++) {
      this.items.push(`Item ${this.items.length}`);
    }
  }
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }
  onSubmit(): void {
    if (this.form.invalid) {
      this.toastr.warning("Please Fill All The Fields",'Warning')
    } else {
      const formData = new FormData();
      formData.append('categoryCode', this.form.value.code);
      formData.append('categoryNameE', this.form.value.nameen);
      formData.append('categoryNameA', this.form.value.namear);
      this.lookupsService.addCategory(formData).subscribe({
        next: (res) => {
          if (res.includes('Category Added Succefully')) {
            this.toastr.success("New Category Added Succefull","Success")
            this.categoriesList.push({
              categoryCode: this.form.value.code,
              categoryNameE: this.form.value.nameen,
              categoryNameA: this.form.value.namear,
            });
            this.form.reset();
          }
        },
        error: (error) => {
          console.log(error.error);
        },
      });
    }
  }
  onScroll() {
    this.getCategories();
    this.loadMoreItems();
  }
  getCategories() {
    this.lookupsService.getCategories().subscribe({
      next: (res) => {
        if (res.length > 0) {
          this.categoriesList = res;
        }
      },
      error: (error) => {
        console.log(error.error);
      },
    });
  }
  sendCategoryName(categoryName: string) {
    const findIndex = this.categoriesList.findIndex(
      (item) => item.categoryCode === categoryName
    );
    if (findIndex !== -1) {
      let categoryId = this.categoriesList[findIndex].categoryId;
      this.lookupsService.getLookupsById(categoryId).subscribe({
        next: (res) => {
          if (res.length > 0) {
            this.Lookupslist = res;
            console.log(this.Lookupslist);
          }
        },
        error: (error) => {
          console.log(error.error);
        },
      });
    }
  }
}
