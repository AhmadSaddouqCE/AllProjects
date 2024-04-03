import {
  AfterViewChecked,
  Component,
  ElementRef,
  OnInit,
  ViewChild,
} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { an } from '@fullcalendar/core/internal-common';
import { IDropdownSettings } from 'ng-multiselect-dropdown';
import { DepartmentService } from '../../DepartmentService/DepartmentService';
import { BranchService } from '../../BranchService/BranchService';
import { DoctorsService } from '../doctors.service';
import { find } from 'rxjs';
import { ToastrService } from 'ngx-toastr';
@Component({
  selector: 'app-add-doctor',
  templateUrl: './add-doctor.component.html',
  styleUrl: './add-doctor.component.css',
})
export class AddDoctorComponent implements OnInit, AfterViewChecked {
  @ViewChild('inputNameE1', { static: true })
  inputNameE1!: ElementRef<HTMLInputElement>;
  @ViewChild('inputNameE2', { static: true })
  inputNameE2!: ElementRef<HTMLInputElement>;
  @ViewChild('inputNameE3', { static: true })
  inputNameE3!: ElementRef<HTMLInputElement>;
  @ViewChild('inputNameE4', { static: true })
  inputNameE4!: ElementRef<HTMLInputElement>;
  @ViewChild('inputNamear1', { static: true })
  inputNamear1!: ElementRef<HTMLInputElement>;
  @ViewChild('inputNamear2', { static: true })
  inputNamear2!: ElementRef<HTMLInputElement>;
  @ViewChild('inputNamear3', { static: true })
  inputNamear3!: ElementRef<HTMLInputElement>;
  @ViewChild('inputNamear4', { static: true })
  inputNamear4!: ElementRef<HTMLInputElement>;
  @ViewChild('inputPhone', { static: true })
  inputPhone!: ElementRef<HTMLInputElement>;
  @ViewChild('inputEmail', { static: true })
  inputEmail!: ElementRef<HTMLInputElement>;
  @ViewChild('inputaddressAr', { static: true })
  inputaddressAr!: ElementRef<HTMLInputElement>;
  @ViewChild('inputaddressEn', { static: true })
  inputaddressEn!: ElementRef<HTMLInputElement>;
  @ViewChild('inputDate', { static: true })
  inputDate!: ElementRef<HTMLInputElement>;
  @ViewChild('inputGender', { static: true })
  inputGender!: ElementRef<HTMLInputElement>;
  @ViewChild('inputBranch', { static: true })
  inputBranch!: ElementRef<HTMLInputElement>;
  @ViewChild('inputDepartment', { static: true })
  inputDepartment!: ElementRef<HTMLInputElement>;
  @ViewChild('inputDate', { static: true })
  inpueDate!: ElementRef<HTMLInputElement>;
  @ViewChild('inputuserName', { static: true })
  inputuserName!: ElementRef<HTMLInputElement>;
  @ViewChild('inputPassword', { static: true })
  inputPassword!: ElementRef<HTMLInputElement>;
  isSidebarExpanded = false;
  selectBranch: string = '';
  selectDepartment: string = '';
  selectGender: string = '';
  selectedGenders: string[] = [];
  selectedDepartments: any[] = [];
  dropdownList: any = [];
  selectedItem!: string;
  dropdownSettings: IDropdownSettings = {};
  map: Map<string, any> = new Map<string, any>();
  dropDownForm!: FormGroup;
  selectedItemsBranch = [];
  namear2!: string;
  DepartmentsList: any[] = [];
  BranchesList: any[] = [];
  selectedFile!: File;
  form!: FormGroup;
  constructor(
    private fb: FormBuilder,
    private DepartmentService: DepartmentService,
    private BranchService: BranchService,
    private doctorService: DoctorsService,
    private toastr:ToastrService
  ) {}
  ngOnInit() {
    this.getAllBranches();
    this.dropdownSettings = {
      idField: 'itemId',
      textField: 'departmentName',
      noDataAvailablePlaceholderText: 'No Departments Available',
      allowSearchFilter: true,
      enableCheckAll: false,
      noFilteredDataAvailablePlaceholderText: 'No Filtered Data Available',
    };
  }
  ngAfterViewChecked(): void {}
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }
  setDepartment(name: any) {
    this.map.set(this.selectBranch, name);
  }
  chooseBranch(branch: string) {
    const findIndex = this.BranchesList.findIndex(
      (item) => item.branchNameE === branch
    );
    if (findIndex !== -1) {
      const branchId = this.BranchesList[findIndex].branchId;
      this.getDepartmentByBranchId(branchId);
      if (!this.map.has(branch)) {
        this.selectedDepartments = [];
      } else {
        this.selectedDepartments = this.map.get(branch);
      }
    }
  }
  getDepartmentByBranchId(Id: string) {
    this.doctorService.getDepartmentsByBranchId(Id).subscribe({
      next: (res) => {
        if (res.length > 0) {
          this.DepartmentsList = res;
          this.DepartmentsList = res.map((dept, index) => ({
            itemId: index,
            departmentName: dept.departmentName,
          }));
        } else {
          this.DepartmentsList = [];
        }
      },
      error: (error) => {
        console.log(error.error);
      },
    });
  }
  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }
  getAllDepartments() {
    this.DepartmentService.getAllDepartments().subscribe({
      next: (res) => {
        if (res.length > 0) {
          this.DepartmentsList = res.map((dept, index) => ({
            itemId: index,
            departmentName: dept.departmentNameA,
          }));
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

  AddDoctor(
    nameE1: string,
    nameE2: string,
    nameE3: string,
    nameE4: string,
    nameAr1: string,
    nameAr2: string,
    nameAr3: string,
    nameAr4: string,
    Phone: string,
    Email: string,
    addressAr: string,
    addressEn: string,
    date: string,
    userName: string,
    Password: string
  ) {
    if (!this.selectedFile) this.toastr.warning("Please upload a file'","Warning")
    else{
    if (
      nameE1 === '' ||
      nameE2 === '' ||
      nameE3 === '' ||
      nameE4 === '' ||
      nameAr1 === '' ||
      nameAr2 === '' ||
      nameAr3 === '' ||
      nameAr4 === '' ||
      Phone === '' ||
      Email === '' ||
      addressAr === '' ||
      addressEn === '' ||
      this.selectGender === '' ||
      this.map.size === 0 ||
      this.selectedDepartments.length === 0 ||
      this.selectBranch === '' ||
      date === '' ||
      userName === '' ||
      Password === ''
    ) {
      this.toastr.warning("Please Fill All The Fields","Warning")
    } else {
      let obj = Object.fromEntries(this.map);
      let jsonString = JSON.stringify(obj);
      const formData = new FormData();
      formData.append('doctorNameE1', nameE1);
      formData.append('doctorNameE2', nameE2);
      formData.append('doctorNameE3', nameE3);
      formData.append('doctorNameE4', nameE4);
      formData.append('doctorNameA1', nameAr1);
      formData.append('doctorNameA2', nameAr2);
      formData.append('doctorNameA3', nameAr3);
      formData.append('doctorNameA4', nameAr4);
      formData.append('Phone', Phone);
      formData.append('Email', Email);
      formData.append('Gender', this.selectGender);
      formData.append('AddressE', addressEn);
      formData.append('AddressA', addressAr);
      formData.append('dateOfBirth', date);
      formData.append('doctorImage', this.selectedFile);
      formData.append('userName', userName);
      formData.append('Password', Password);
      formData.append('BranchesDepartments', jsonString);
      this.doctorService.addDoctor(formData).subscribe({
        next: (res) => {
          if (res.includes('New doctor added Succefully')){
            alert("New doctor added Succefully")
            this.form.reset();
          }
        },
        error: (error) => {
          console.log(error.error);
        },
      });
    }
  }
}
}
