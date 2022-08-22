import {Component, OnInit} from '@angular/core';
import {Location} from '@angular/common';
import {User} from "../../models/User";
import {UserService} from "../../services/user.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  user: User;

  constructor( private location: Location,
               private userService: UserService,
               private router: Router) {
    this.user = new User();

  }

  
  Space(event:any){
    console.log(event)
    console.log(event.target.selectionStart)
   if(event.target.selectionStart ===0 && event.code === "Space")
     event.preventDefault();
   var code = event.keyCode;
   if((code >= 65 && code<=90) || (code >= 97 && code <= 122) || (code == 32) || (code == 8)||(code==39)||(code==37) ){
     return true;
   }else{
     return false;
   }
 } 

 
 SpaceP(event:any){
  console.log(event)
  console.log(event.target.selectionStart)
 if(event.target.selectionStart ===0 && event.code === "Space")
   event.preventDefault();
}

restrictZero(event:any){
  if(event.target.value.length === 0 && event.key ==="0")
  event.preventDefault();
  console.log(event) 
} 


  ngOnInit() {


  }
  onSubmit() {
    this.userService.signUp(this.user).subscribe(u => {
      this.router.navigate(['/login']);
    },
        e => {});
  }

}
