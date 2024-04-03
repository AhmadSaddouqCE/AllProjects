import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { faAdd, faEdit, faTrash } from '@fortawesome/free-solid-svg-icons';
import { BranchService } from '../BranchService/BranchService';
import { DoctorsService } from '../doctors/doctors.service';
import { SetupSerive } from './Setup.Service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-appointment-setup',
  templateUrl: './appointment-setup.component.html',
  styleUrl: './appointment-setup.component.css',
})
export class AppointmentSetupComponent implements OnInit {
  isSidebarExpanded = false;
  selectGender!: string;
  selectBranch!: string;
  selectDepartment!: string;
  Doctors!: string;
  selectedDepartmentSetup!: string;
  selectDay = 'Saturday';
  fromTime!: string;
  toTime!: string;
  breakIn!: string;
  breakOut!: string;
  statusCheck!: any;
  icon = faAdd;
  modify = faEdit;
  delete = faTrash;
  selectBranchForDepartment!: string;
  listOfBranches: any[] = [];
  DepartmentsList: any[] = [];
  setDuration!: string;
  setDepartmentForSetup!: string;
  DoctorsList: any[] = [];
  listOfDays: any[] = [
    'Saturday',
    'Sunday',
    'Monday',
    'Thusday',
    'Wedenesday',
    'Thursday',
    'Friday',
  ];
  selectedDoctor!: string;
  constructor(
    private branchService: BranchService,
    private DoctorService: DoctorsService,
    private SetupService: SetupSerive,
    private cdr: ChangeDetectorRef,
    private toastr:ToastrService
  ) {}
  ngOnInit(): void {
    this.getAllBranches();
  }
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }

  timeEntries = this.listOfDays.map((day) => ({
    dayOfWeek: day,
    fromTime: '',
    toTime: '',
    breakIn: '',
    breakOut: '',
    durationInMinutes: this.setDuration,
    doctorId: '',
    departmentId: '',
    branchId: '',
  }));
  clear(index: number): void {
    const dayOfWeek = this.timeEntries[index].dayOfWeek;
    this.timeEntries[index] = {
      dayOfWeek: dayOfWeek,
      fromTime: '',
      toTime: '',
      breakIn: '',
      breakOut: '',
      durationInMinutes: '',
      doctorId: '',
      departmentId: '',
      branchId: '',
    };
  }

  setDepartments(selectedBranch: string) {
    const findBranchIndex = this.listOfBranches.findIndex(
      (item) => item.branchNameE === selectedBranch
    );
    if (findBranchIndex !== -1) {
      let branchId = this.listOfBranches[findBranchIndex].branchId;
      this.getDepartmentByBranchId(branchId);
    }
  }
  getDepartmentByBranchId(Id: string) {
    this.DoctorService.getDepartmentsByBranchId(Id).subscribe({
      next: (res) => {
        if (res.length > 0) {
          this.DepartmentsList = res;
        } else {
          this.DepartmentsList = [];
        }
      },
      error: (error) => {
        console.log(error.error);
      },
    });
  }
  submitTimeEntries() {
    const findDoctorIndex = this.DoctorsList.findIndex(
      (item) => item.doctorNameE === this.selectedDoctor
    );
    const findBranchIndex = this.listOfBranches.findIndex(
      (item) => item.branchNameE === this.selectBranchForDepartment
    );
    const findDepartmentIndex = this.DepartmentsList.findIndex(
      (item) => item.departmentName === this.setDepartmentForSetup
    );
    if (
      findDoctorIndex !== -1 &&
      findBranchIndex !== -1 &&
      findDepartmentIndex !== -1
    ) {
      let doctorId = this.DoctorsList[findDoctorIndex].doctorId;
      let branchId = this.listOfBranches[findBranchIndex].branchId;
      let departmentId = this.DepartmentsList[findDepartmentIndex].departmentId;
      this.timeEntries.forEach((entry) => {
        entry.durationInMinutes = this.setDuration;
        entry.doctorId = doctorId;
        entry.departmentId = departmentId;
        entry.branchId = branchId;
      });
      this.SetupService.addDoctorSetup(this.timeEntries).subscribe({
        next: (res) => {
          if (res.includes('New Setup Added')) {
            this.toastr.success("New Setup Added","Success")
          }
        },
        error: (error) => {
          console.log(error.error);
        },
      });
    }
  }
  getAllBranches() {
    this.branchService.getAllBranches().subscribe({
      next: (res) => {
        if (res.length > 0) {
          this.listOfBranches = res;
        }
      },
      error: (error) => {
        console.log(error.error);
      },
    });
  }
  getAppointmentDetails() {
    const findDoctorIndex = this.DoctorsList.findIndex(
      (item) => item.doctorNameE === this.selectedDoctor
    );
    const findBranchIndex = this.listOfBranches.findIndex(
      (item) => item.branchNameE === this.selectBranchForDepartment
    );
    const findDepartmentIndex = this.DepartmentsList.findIndex(
      (item) => item.departmentName === this.setDepartmentForSetup
    );
    if (
      findDoctorIndex !== -1 &&
      findBranchIndex !== -1 &&
      findDepartmentIndex !== -1
    ) {
      let doctorId = this.DoctorsList[findDoctorIndex].doctorId;
      let branchId = this.listOfBranches[findBranchIndex].branchId;
      let departmentId = this.DepartmentsList[findDepartmentIndex].departmentId;
      const formData = new FormData();
      formData.append('doctorId', doctorId);
      formData.append('branchId', branchId);
      formData.append('departmentId', departmentId);
      this.SetupService.getDoctorDetails(formData).subscribe({
        next: (res) => {
          if (res.length > 0) {
            this.timeEntries = res.map((detail: any) => ({
              dayOfWeek: detail.dayOfWeek,
              fromTime: detail.fromTime,
              toTime: detail.toTime,
              breakIn: detail.breakIn,
              breakOut: detail.breakOut,
              durationInMinutes: detail.durationInMinutes,
            }));
          }
        },
        error: (error) => {
          console.log(error.error);
        },
      });
    }
  }

  sendDepartentName(departmentNameE: string) {
    this.selectedDoctor = "";
    this.setDuration = '';
    this.timeEntries = this.listOfDays.map((day) => ({
      dayOfWeek: day,
      fromTime: '',
      toTime: '',
      breakIn: '',
      breakOut: '',
      durationInMinutes: this.setDuration,
      doctorId: '',
      departmentId: '',
      branchId: '',
    }));
    this.setDepartmentForSetup = departmentNameE;
    const findDepartmentIndex = this.DepartmentsList.findIndex(
      (item) => item.departmentName === this.setDepartmentForSetup
    );
    const findBranchIndex = this.listOfBranches.findIndex(
      (item) => item.branchNameE === this.selectBranchForDepartment
    );
    if (findBranchIndex !== -1 && findDepartmentIndex !== -1) {
      var branchId = this.listOfBranches[findBranchIndex].branchId;
      var departmentId = this.DepartmentsList[findDepartmentIndex].departmentId;
      const formData = new FormData();
      formData.append('branchId', branchId);
      formData.append('departmentId', departmentId);
      this.SetupService.getDoctorDepartments(formData).subscribe({
        next: (res: any) => {
          this.DoctorsList = res;
        },
        error: (error) => {
          this.DoctorsList = [];
          console.log(error.error);
        },
      });
    }
  }
}
