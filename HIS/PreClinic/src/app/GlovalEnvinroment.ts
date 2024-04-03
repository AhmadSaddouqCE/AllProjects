import { HttpHeaders } from '@angular/common/http';

export class GlobalEnvironmentService {
  url = 'https://localhost:7029/';
  headers = new HttpHeaders({
    'Content-type': 'application/json;',
  });
}
