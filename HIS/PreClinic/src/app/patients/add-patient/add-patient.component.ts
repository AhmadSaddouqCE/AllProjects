import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { PatientService } from '../patients.Service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-add-patient',
  templateUrl: './add-patient.component.html',
  styleUrl: './add-patient.component.css',
})
export class AddPatientComponent {
  form!: FormGroup;
  isSidebarExpanded = false;
  selectGender!: string;
  selectedFile!: File;
  constructor(
    private fb: FormBuilder,
    private PatientService: PatientService,
    private toastr: ToastrService
  ) {
    this.form = this.fb.group({
      cardId: [null, [Validators.required], []],
      nameen1: [null, [Validators.required], []],
      nameen2: [null, [Validators.required], []],
      nameen3: [null, [Validators.required], []],
      nameen4: [null, [Validators.required], []],
      namear1: [null, [Validators.required], []],
      namear2: [null, [Validators.required], []],
      namear3: [null, [Validators.required], []],
      namear4: [null, [Validators.required], []],
      phone: [null, [Validators.required], []],
      email: [null, [Validators.required], []],
      date: [null, [Validators.required], []],
      addressar: [null, [Validators.required], []],
      addressen: [null, [Validators.required], []],
      gender: [null, [Validators.required], []],
    });
  }
  toggleSidebar() {
    this.isSidebarExpanded = !this.isSidebarExpanded;
  }
  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }
  addPatient() {
    if (this.form.invalid || !this.selectedFile) {
      alert('Please Fill All The Fields');
    } else {
      const formData = new FormData();
      formData.append('cardId', this.form.value.cardId);
      formData.append('patientNameE1', this.form.value.nameen1);
      formData.append('patientNameE2', this.form.value.nameen2);
      formData.append('patientNameE3', this.form.value.nameen3);
      formData.append('patientNameE4', this.form.value.nameen4);
      formData.append('patientNameA1', this.form.value.namear1);
      formData.append('patientNameA2', this.form.value.namerr2);
      formData.append('patientNameA3', this.form.value.namear3);
      formData.append('patientNameA4', this.form.value.namear4);
      formData.append('Email', this.form.value.email);
      formData.append('Gender', this.form.value.gender);
      formData.append('dateOfBirth', this.form.value.date);
      formData.append('addressA', this.form.value.addressar);
      formData.append('addressE', this.form.value.addressen);
      formData.append('Phone', this.form.value.phone);
      formData.append('patientImage', this.selectedFile);
      this.PatientService.addPatient(formData).subscribe({
        next: (res) => {
          if (res.includes('New Patient Added')) {
            this.toastr.success("New Patient Added Succefully","Success")
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
