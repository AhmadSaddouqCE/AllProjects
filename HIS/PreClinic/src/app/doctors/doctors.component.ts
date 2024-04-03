import { AfterViewChecked, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import {
  faAdd,
  faCoffee,
  faEdit,
  faTrash,
} from '@fortawesome/free-solid-svg-icons';
import { IDropdownSettings } from 'ng-multiselect-dropdown';
import { DoctorsService } from './doctors.service';
@Component({
  selector: 'app-doctors',
  templateUrl: './doctors.component.html',
  styleUrl: './doctors.component.css',
})
export class DoctorsComponent implements OnInit, AfterViewChecked {
  constructor(
    router: Router,
    route: ActivatedRoute,
    private DoctorsService: DoctorsService
  ) {}
  isSidebarExpanded = false;
  icon = faAdd;
  modify = faEdit;
  delete = faTrash;
  isDoctorModified!: string;
  Message!: string;
  selectDepartment!: string;
  selectedStatus: string = 'active';
  selectGender!: string;
  selectBranch!: string;
  DoctorsList: any[] = [];
  currentPage = 1;
  totalDoctors = 0;
  pageSize = 5;
  ngOnInit(): void {
    this.loadDoctors();
  }
  ngAfterViewChecked(): void {
  }
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }
  loadDoctors(page: number = 1) {
    this.DoctorsService.getDoctors(page,this.pageSize).subscribe({
      next: (data) => {
        this.DoctorsList = data.doctors;
        this.totalDoctors = data.totalCount;
        console.log(this.DoctorsList)
      },
      error: (error) => console.error('There was an error!', error),
    });
  }

  onPageChange(page: number) {
    this.currentPage = page;
    this.loadDoctors(page);
  }
  get totalPages(): number {
    return Math.ceil(this.totalDoctors / this.pageSize);
  }

  get pages(): number[] {
    return Array(this.totalPages).fill(0).map((x, i) => i + 1);
  }
  onScroll() {
    this.loadDoctors()
    // this.loadMoreItems();
  }
  nextPage() {
    if (this.currentPage < this.totalPages) {
      this.onPageChange(this.currentPage + 1);
    }
  }

  previousPage() {
    if (this.currentPage > 1) {
      this.onPageChange(this.currentPage - 1);
    }
  }
}
