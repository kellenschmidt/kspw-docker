import { Component, ElementRef, Input, EventEmitter, Output, OnChanges } from '@angular/core';
import { CloudinaryResponse } from '../../_models/cloudinary-response';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from "rxjs/Rx";

@Component({
    selector: 'image-upload',
    template: '<form><input type="file" accept="image/*" (change)="uploadFile($event)"></form>'
})

export class ImageUploadComponent {

    @Input() public public_id: string;
    @Output() public uploaded: EventEmitter<boolean> = new EventEmitter<boolean>();

    constructor(private http: HttpClient) {}

    uploadFile(fileInput: any){
        this.upload(fileInput).subscribe(x => {
            if(!x.public_id){
                this.uploaded.emit(false);
            } else {
                this.uploaded.emit(true);
            }
        });
    }

    upload(fileInput: any): Observable<CloudinaryResponse> {
        let formData: FormData = new FormData();

        formData.append('file', fileInput.target.files[0]);
        formData.append('upload_preset', 'knlspx3g');

        return this.http.post<CloudinaryResponse>('https://api.cloudinary.com/v1_1/dwymiyvae/image/upload', formData, {headers: new HttpHeaders().set('Content-Type', 'application/x-www-form-urlencoded')})
            .catch(x => this.handleException(x));
    }

    handleException(exception: any) {
        var message = `${exception.status} : ${exception.statusText}\r\n${exception.body.error}`;
        alert(message);
        this.uploaded.emit(false);
        return Observable.throw(message);
    }

}
