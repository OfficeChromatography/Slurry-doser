/*
MIT License

Copyright (c) 2016, Dimitri FIchou, Gertrud Morlock

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

// script for adapting the layer printing functionnality on the prusa i3

// we need several prat:
    // plate holder, should we split it in 2 ?
    // syringe system 
    
// syringe system
    // motor
    // syringe
    // captor: end stop contact or inductif ?
    
// plate holder
    // 
include<vitamine.scad>
rabio = 1;

use_lm6uu = false;

stand_thick = 8;

X_M4_gap = 23/2;
Z_M4_gap = 22/2;
Z_plate_M4_gap = 50 + Z_M4_gap;

holder_y = stand_thick;
holder_x = 50;
holder_z = 45;
holder_y_bis = 3;
holder_x_bis = nema_xy+2*12;
holder_z_bis = 80;

carriage_x = 56;
carriage_y = 12.5;
carriage_z = 68;
carriage_y_gap = -65;


nema_z_gap = Z_plate_M4_gap+holder_z/2+nema_axe_h/2-stand_thick;
nema_y_gap = carriage_y_gap+holder_y+nema_xy/2+carriage_y/2;

holder_bis_y_gap  = nema_y_gap+nema_xy/2+holder_y_bis/2;

rod_d = 6;
rod_h = 200;
rod_fil_d = 8;
rod_fil_h = 150;
rod_x_gap = 27;
rod_y_gap = nema_y_gap;

syringe_x_gap = -nema_xy/4;

sensor_X_gap = nema_xy/4-3;
sensor_Y_gap = nema_xy/6;

module rods(rabio=0){
    for(i = [-1,1]){
        color("green") translate([i*rod_x_gap,rod_y_gap,rod_h/2+Z_plate_M4_gap-nema_z/2+stand_thick/2]) cylinder(d=rod_d+rabio,h=rod_h,center=true);
    }
    translate([0,nema_y_gap,nema_z_gap]) cylinder(d=rod_fil_d,h=rod_fil_h);
}



syringe_needle_d = 4; // 2.4 in reality
syringe_needle_h = 40; // 
syringe_pink_d = 7; // 5.7 in reality
syringe_pink_h = 17.2; // 
syringe_body_d = 17.3; // 
syringe_body_h = 75; // 
syringe_flange_d = 31; // 
syringe_flange_h = 2; // 
syringe_piston_in_d = 20; // 
syringe_piston_in_h = 13.3; // 
syringe_piston_out_d = 20; //
syringe_piston_out_h = 73.7; // 
syringe_Y_gap_body_etc = 17.3/2-(0.8+2.25);
module syringe(rabio=rabio,inside = 1){
   translate([syringe_x_gap,0,0]) union() {
        translate([0,0,0]) cylinder(d = syringe_needle_d+rabio,h = syringe_needle_h);
        translate([0,0,syringe_needle_h]) cylinder(d = syringe_pink_d+rabio,h = syringe_pink_h);
        translate([0,syringe_Y_gap_body_etc,syringe_needle_h+syringe_pink_h]) cylinder(d = syringe_body_d+rabio,h = syringe_body_h);
        translate([0,syringe_Y_gap_body_etc,syringe_needle_h+syringe_pink_h+syringe_body_h]) cylinder(d = syringe_flange_d+rabio,h = syringe_flange_h);
        translate([0,syringe_Y_gap_body_etc,syringe_needle_h+syringe_pink_h+syringe_body_h+syringe_flange_h]) cylinder(d = syringe_piston_in_d +rabio,h = syringe_piston_in_h+inside*(syringe_piston_out_h-syringe_piston_in_h));
    }
}
    

module X_carrige(){
    color("black") translate([0,carriage_y_gap,Z_plate_M4_gap]) cube([carriage_x,carriage_y,carriage_z],center=true);
}




module bed(){
    translate([0,0,-1]) cube([210,210,2],center=true);
}



module M4(){
    union(){
        for(i = [-1,1]){
            for(j = [-1,1]){
                    translate([X_M4_gap*i,carriage_y_gap,j*Z_M4_gap]) rotate([90,0,0]) cylinder(d=4+rabio,h=50,center=true);
            }
        }
    }
}

module M4_ecrou(){
    union(){
        for(i = [-1,1]){
            for(j = [-1,1]){
                    translate([X_M4_gap*i,carriage_y_gap+carriage_y/2+holder_y,j*Z_M4_gap+Z_plate_M4_gap]) rotate([90,0,0]) cylinder(d=7+rabio*2,h=7,center=true,$fn=6);
            }
        }
    }
}

module M3_link(){
    for(i = [-1,1]){
                translate([rod_x_gap*i,nema_y_gap+nema_xy/2,Z_plate_M4_gap+holder_z/2-stand_thick/2]) rotate([90,0,0]) cylinder(d=3+rabio,h=30,center=true);
                translate([rod_x_gap*i,nema_y_gap+nema_xy/2,Z_plate_M4_gap-holder_z/2+stand_thick/2])  rotate([90,0,0]) cylinder(d=3+rabio,h=30,center=true);
            }
}

module holder(){
    difference(){
        union(){
            translate([0,carriage_y_gap+carriage_y/2+holder_y/2,Z_plate_M4_gap]) cube([holder_x,holder_y,holder_z],center=true);
            translate([0,nema_y_gap,Z_plate_M4_gap]) cube([holder_x,nema_xy,holder_z],center=true); // needed for cooling
            translate([0,nema_y_gap,Z_plate_M4_gap+holder_z/2-stand_thick/2]) cube([nema_xy,nema_xy,stand_thick],center=true);
            for(i = [-1,1]){
                translate([rod_x_gap*i,nema_y_gap-holder_y/2,Z_plate_M4_gap+holder_z/2-stand_thick/2]) cube([12,nema_xy+holder_y,stand_thick],center=true);
                translate([rod_x_gap*i,nema_y_gap-holder_y/2,Z_plate_M4_gap-holder_z/2+stand_thick/2]) cube([12,nema_xy+holder_y,stand_thick],center=true);
            }
        }
        union(){
            translate([0,nema_y_gap,nema_z_gap]) nema17_neg(rabio=rabio);
            rods(rabio=rabio);
            translate([0,0,Z_plate_M4_gap]) M4();
            M4_ecrou();
            M3_link();
            syringe();
            for(i = [-1,1]){
                translate([i*rod_x_gap,carriage_y_gap+carriage_y*2.1,Z_plate_M4_gap*2]) cylinder(d=4+rabio*2,h=50,center=true);
            }
            translate([sensor_X_gap,-5,syringe_needle_h-5]) cube([18,32,5],center=true); // sensor
            translate([sensor_X_gap,0,0]) inductif_sensor(rabio=rabio*2);
        }
    }
}

module syringe_holder(){
    difference(){
        union(){
            translate([0,holder_bis_y_gap,Z_plate_M4_gap+10]) cube([holder_x_bis,holder_y_bis,holder_z_bis],center=true); // plate
            translate([syringe_x_gap,0,syringe_needle_h]) cube([15,(holder_y_bis-holder_bis_y_gap)+syringe_pink_d,15],center=true); // syringe
            translate([sensor_X_gap,0,syringe_needle_h]) cube([25,(holder_y_bis-holder_bis_y_gap)+syringe_pink_d,15],center=true); // sensor 1
            translate([sensor_X_gap,sensor_Y_gap,syringe_needle_h]) cylinder(d=inductif_d*2,h=15,center=true); // sensor 2
            translate([syringe_x_gap,0,nema_z_gap+10]) cube([40,(holder_y_bis-holder_bis_y_gap)+syringe_pink_d,20],center=true);//caps holder 1
            
        }
        union(){
            translate([sensor_X_gap,sensor_Y_gap,0]) inductif_sensor(rabio=rabio*3);
            M3_link();
            syringe(rabio=rabio);
            translate([syringe_x_gap,holder_y_bis,nema_z_gap+10]) cube([40+rabio,(holder_y_bis-holder_bis_y_gap)+syringe_pink_d,10],center=true);//caps holder hole
            for(i = [-1,1]){
                translate([syringe_x_gap+i*nema_xy/3,3,nema_z_gap+10]) cylinder(d=4+rabio,h=30,center=true);//caps holder hole
            }
        }
    }
}

module syringe_caps(){
    difference(){
        union(){
            for(i = [-1,1]){
                hull(){
                    translate([syringe_x_gap+i*nema_xy/3,3,nema_z_gap+10]) cylinder(d=10+rabio,h=5,center=true);//caps holder hole
                    translate([syringe_x_gap,20,nema_z_gap+10]) cylinder(d=10+rabio,h=5,center=true);//caps holder hole
                }
                
            }
        }
        union(){
            syringe(rabio=rabio);
            for(i = [-1,1]){
                translate([syringe_x_gap+i*nema_xy/3,3,nema_z_gap+10]) cylinder(d=4+rabio,h=30,center=true);//caps holder hole
            }
        }
    }
}

module syringe_moving(){
    difference(){
        hull(){
            translate([0,nema_y_gap,nema_z_gap+100]) cylinder(d=25,h=10,center=true);
            for(i = [-1,1]){
                translate([i*rod_x_gap,rod_y_gap,nema_z_gap+100]) cylinder(d=25,h=10,center=true);
            }
            translate([syringe_x_gap,syringe_Y_gap_body_etc,nema_z_gap+100]) cylinder(d = syringe_piston_in_d ,h = 10,center=true);
        }
        union(){
            translate([0,nema_y_gap,nema_z_gap+60]) tr8_nut_neg(rabio=rabio);
            
            for(i = [-1,1]){
                if(use_lm6uu == true){
                    translate([i*rod_x_gap,nema_y_gap,nema_z_gap+100]) cylinder(d=lm6uu_OD+rabio,h=20,center=true);
                } else {
                   translate([i*rod_x_gap,nema_y_gap,nema_z_gap+100]) cylinder(d=10+rabio,h=20,center=true);
                }
            }
        }
    }
}

module full_view(){
    //syringe(inside=$t);
    color("turquoise")  syringe(rabio=0,inside=0);
    color("gold")  syringe_caps();
    color("gold")  syringe_holder();
    color("gold")  syringe_moving();
    translate([0,nema_y_gap,nema_z_gap]) color("pink") nema17();
    color("blue")  translate([0,nema_y_gap,nema_z_gap]) coupler();
    bed();
    X_carrige();
   color("gold")  holder();
    rods();
    color("yellowgreen")  translate([0,nema_y_gap,nema_z_gap+100]) tr8_nut();
    translate([sensor_X_gap,sensor_Y_gap,0]) inductif_sensor();
}
full_view();
//translate([0,-200,0]) rotate([90,0,0]) holder();
//translate([0,-200,0]) syringe_moving();
//translate([0,-200,0]) syringe_caps();
//rotate([90,0,0])   syringe_holder();