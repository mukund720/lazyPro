import { Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { ProfileComponent } from './profile/profile.component';

export const routes: Routes = [
    {path:"login",loadComponent:()=>import("./login/login.component").then(comp=>comp.LoginComponent)},
    {path:"profile",loadComponent:()=>import("./profile/profile.component").then(c=>c.ProfileComponent)}

];
