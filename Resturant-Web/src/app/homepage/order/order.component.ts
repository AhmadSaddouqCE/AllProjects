import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.css'],
})
export class OrderComponent {
  orderForm!: FormGroup;
  statusOptions = ['Available', 'Not Available'];

  constructor(private formBuilder: FormBuilder) {
    this.orderForm = this.formBuilder.group({
      status: ['Available', Validators.required] 
    });
  }
}
