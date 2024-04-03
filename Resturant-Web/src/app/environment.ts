import { HttpHeaders } from '@angular/common/http';

export class GlobalEnvironment {
  url = 'https://localhost:7142/';
  headers = new HttpHeaders({
    'Content-type': 'application/json;',
  });
  fileHeaders = new HttpHeaders({
    'Content-Type': 'multipart/form-data',
  });
}
