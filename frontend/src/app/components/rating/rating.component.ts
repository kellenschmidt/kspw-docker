import { Component, Input, Output, OnInit, EventEmitter } from '@angular/core';

@Component({
  selector: 'rating',
  templateUrl: './rating.component.html',
  styleUrls: ['./rating.component.scss']
})

export class RatingComponent {

	stars: number;
	userHasRated: boolean;
	clickStars: boolean;

	@Input() public ratingValue: number;
	@Output() public onRated = new EventEmitter<number>();

	ngOnInit() {
		if(this.ratingValue === 0)
		{
			this.clickStars = true;
		}

		else
		{
			this.clickStars = false;
			this.stars = Math.round(this.ratingValue * 2)/2;
		}
	}

	public rated(num: number){
		this.onRated.emit(num);
		this.ratingValue = num;
	}
}
