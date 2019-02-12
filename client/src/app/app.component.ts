import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'app';

  constructor() {}

  download = () => {
    const params = {
      just: '1',
      http: '2',
      params: '3'
    }

    const form = document.createElement("form");
    Object.keys(params).forEach(key => {
      const input = document.createElement("input");
      input.name = key;
      input.value = params[key];
      form.appendChild(input);
    });

    form.method = "POST";
    form.action = "/export";

    document.body.appendChild(form);
    form.submit();

    document.body.removeChild(form);
  }
}
