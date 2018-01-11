import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material';

import { AuthService } from '../../_services/auth.service';
import { Login } from '../../_models/login';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  auth: Login = new Login();
  username: string;

  constructor(
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) { }

  ngOnInit() {
  }

  submit() {
    this.username = this.auth.username;
    this.authService.login(this.auth).subscribe(
      res => {
        this.checkAuth(res.status);
      },
      err => {
        this.snackBar.open('Login failed, please try again', '', {
          duration: 5000
        });
      }
    );
  }

  checkAuth(status) {
    if(status == 200) {
      localStorage.setItem('auth', this.authService.getJWT({user: this.username}));
    } else {
      this.snackBar.open('Login failed, please try again', '', {
        duration: 5000
      });
      return;
    }

    this.router.navigate(['/dashboard']);
  }

}
