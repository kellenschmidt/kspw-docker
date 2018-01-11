import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { MatSnackBarModule } from '@angular/material';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';

import { AppRoutingModule } from '../../_modules/app-routing/app-routing.module';

import { ProfileService } from '../../_services/profile.service';
import { LocationService } from '../../_services/location.service';

import { RatingComponent } from '../../components/rating/rating.component';
import { CommentComponent } from '../../components/comment/comment.component';
import { ImageUploadComponent } from '../../components/image-upload/image-upload.component';

@NgModule({
  declarations: [
    RatingComponent,
    CommentComponent,
    ImageUploadComponent
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    MatSnackBarModule,
    NoopAnimationsModule,
    AppRoutingModule
  ],
  providers: [
    ProfileService,
    LocationService
  ],
  exports: [
    RatingComponent,
    CommentComponent,
    AppRoutingModule
  ]
})
export class SharedModule { }
