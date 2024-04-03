import { Component, OnInit } from '@angular/core';
import {
  faAdd,
  faCoffee,
  faEdit,
  faTrash,
} from '@fortawesome/free-solid-svg-icons';
import { PatientService } from './patients.Service';
@Component({
  selector: 'app-patients',
  templateUrl: './patients.component.html',
  styleUrl: './patients.component.css'
})
export class PatientsComponent implements OnInit {
  isSidebarExpanded = false;
  icon = faAdd;
  modify = faEdit;
  delete = faTrash;
  selectDepartment!:string
  selectedStatus: string = 'active';
  selectGender!:string
  selectBranch!:string
  currentPage = 1;
  totalPatients = 0;
  pageSize = 5;
  PatientsList: any[] = [];

  constructor(private PatientService: PatientService){}
  ngOnInit(): void {
    this.loadPatients()
  }
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }
  loadPatients(page: number = 1) {
    this.PatientService.getPatients(page,this.pageSize).subscribe({
      next: (data) => {
        this.PatientsList = data.patients;
        this.totalPatients = data.totalCount;
        console.log(this.PatientsList)
      },
      error: (error) => console.error('There was an error!', error),
    });
  }

  onPageChange(page: number) {
    this.currentPage = page;
    this.loadPatients(page);
  }
  get totalPages(): number {
    return Math.ceil(this.totalPatients / this.pageSize);
  }

  get pages(): number[] {
    return Array(this.totalPages).fill(0).map((x, i) => i + 1);
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
  print() {}
}
