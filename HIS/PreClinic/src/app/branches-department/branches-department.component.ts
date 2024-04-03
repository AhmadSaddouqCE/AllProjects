import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { BranchesDepartmentsService } from './branches-departments.serivce';
import { BranchService } from '../BranchService/BranchService';
import { DepartmentService } from '../DepartmentService/DepartmentService';
import { co } from '@fullcalendar/core/internal-common';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-branches-department',
  templateUrl: './branches-department.component.html',
  styleUrl: './branches-department.component.css',
})
export class BranchesDepartmentComponent implements OnInit {
  isSidebarExpanded = false;
  formDepartment!: FormGroup;
  formBranch!: FormGroup;
  formDepartmentBranch!: FormGroup;
  BranchesList: any[] = [];
  DepartmentsList: any[] = [];
  constructor(
    private fb: FormBuilder,
    private branchDepartmentService: BranchesDepartmentsService,
    private BranchService: BranchService,
    private DepartmentService: DepartmentService,
    private toastr:ToastrService
  ) {
    this.formDepartment = this.fb.group({
      departmentNameE: [null, [Validators.required], []],
      departmentNameA: [null, [Validators.required], []],
    });
    this.formBranch = this.fb.group({
      branchNameE: [null, [Validators.required], []],
      branchNameA: [null, [Validators.required], []],
    });
    this.formDepartmentBranch = this.fb.group({
      branch: [null, [Validators.required], []],
      department: [null, [Validators.required], []],
    });
  }
  ngOnInit(): void {
    this.getAllBranches();
    this.getAllDepartments();
  }
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }
  addDepartment() {
    if (this.formDepartment.invalid) this.toastr.warning("Please Fill All The Fields","Warning")

    else {
      const formData = new FormData();
      formData.append(
        'departmentNameE',
        this.formDepartment.value.departmentNameE
      );
      formData.append(
        'departmentNameA',
        this.formDepartment.value.departmentNameA
      );
      this.branchDepartmentService.addDepartment(formData).subscribe({
        next: (res) => {
          if (res.message === "New Department Added Succefully") {
            this.toastr.success("New Department Added Succefully","Success")
            this.DepartmentsList.push({
              departmentNameE: this.formDepartment.value.departmentNameE,
              departmentId:res.departmentId
            });
            this.formDepartment.reset();
          }
        },
        error: (error) => {
          console.log('This User Does Exist');
        },
      });
    }
  }
  addBranch() {
    if (this.formBranch.invalid) alert('Please Fill All The Fields');
    else {
      const formData = new FormData();
      formData.append('branchNameE', this.formBranch.value.branchNameE);
      formData.append('branchNameA', this.formBranch.value.branchNameA);
      this.branchDepartmentService.addBranch(formData).subscribe({
        next: (res:any) => {
          if (res.message === "Branch Added Succefully") {
            this.toastr.success("Branch Added Succefully",'Success')
            this.BranchesList.push({
              branchNameE: this.formBranch.value.branchNameE,
              branchId:res.newBranchId
            });
            this.formBranch.reset();
          }
        },
        error: (error) => {
          console.log(error.error);
        },
      });
    }
  }
  addDepartmentToBranch() {
    if (this.formDepartmentBranch.invalid) this.toastr.warning("Please Fill All The Fields","Warning")
    else {
      const findDepartmentIndex = this.DepartmentsList.findIndex(
        (item) =>
          item.departmentNameE === this.formDepartmentBranch.value.department
      );
      const findBranchIndex = this.BranchesList.findIndex(
        (item) => item.branchNameE === this.formDepartmentBranch.value.branch
      );
      if (findDepartmentIndex !== -1 && findBranchIndex !== -1) {
        const formData = new FormData();
        formData.append(
          'departmentId',
          this.DepartmentsList[findDepartmentIndex].departmentId
        );
        formData.append(
          'branchId',
          this.BranchesList[findBranchIndex].branchId
        );
        this.branchDepartmentService.addDepartmentToBranch(formData).subscribe({
          next: (res) => {
            if (res.includes('Added Succefully'))
              this.toastr.success("Department Added To Branch Succefully","Success")
              this.formDepartmentBranch.reset()
          },
          error: (error) => {
            console.log(error.error);
          },
        });
      }
    }
  }
  getAllDepartments() {
    this.DepartmentService.getAllDepartments().subscribe({
      next: (res) => {
        if (res.length > 0) {
          this.DepartmentsList = res;
        }
      },
      error: (error) => {
        console.log(error.error);
      },
    });
  }
  getAllBranches() {
    this.BranchService.getAllBranches().subscribe({
      next: (res) => {
        if (res.length > 0) {
          this.BranchesList = res;
        }
      },
      error: (error) => {
        console.log(error.error);
      },
    });
  }
}
