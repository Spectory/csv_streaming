import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './components/home/home.component';

export const routes = [
	{ path: '', redirectTo: '/', pathMatch: 'full' },
	{ path: 'home', component: HomeComponent }
];
