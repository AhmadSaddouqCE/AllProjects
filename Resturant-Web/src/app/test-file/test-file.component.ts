import { Component } from '@angular/core';

@Component({
  selector: 'app-test-file',
  templateUrl: './test-file.component.html',
  styleUrls: ['./test-file.component.css']
})
export class TestFileComponent {
  showSignIn = true;

  toggleForm() {
    this.showSignIn = !this.showSignIn;
  }
}
