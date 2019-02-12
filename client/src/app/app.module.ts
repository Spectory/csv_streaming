import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';

import { routes } from './routes';

import { AppComponent } from './app.component';
import { HttpModule }    from '@angular/http';
import { HomeComponent } from './components/home/home.component';

import { DataService } from './services/data.service';
import { AjaxService } from './services/ajax.service';


@NgModule({
  declarations: [
    AppComponent,
    HomeComponent
  ],
  imports: [
    RouterModule.forRoot(routes, {useHash: true}),
    BrowserModule,
    HttpModule
  ],
  providers: [
    DataService,
    AjaxService

  ],
  bootstrap: [AppComponent]
})

export class AppModule {
	constructor() {
	}
}
