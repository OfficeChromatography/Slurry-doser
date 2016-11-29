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


rabio = 0.5; //will be overwritten in the actual file

// nema17: 
nema_xy = 42.3;
nema_z = 47;
nema_cyl_d = 25;
nema_cyl_h = 2;
nema_axe_r = 2.5;
nema_axe_h = 24;
nema_vis_space = nema_xy/2-4-1.5;


module nema17(rabio=0) {
translate([0,0,-nema_z/2-nema_axe_h/2])
union(){
cube([nema_xy+rabio,nema_xy+rabio,nema_z+rabio],center=true);
translate([0,0,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h,d=nema_axe_r*2+rabio,center=true);
translate([0,0,nema_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,d=nema_cyl_r*2+rabio,center=true);
}
}

module nema17_neg(rabio=0) {
translate([0,0,-nema_z/2-nema_axe_h/2])
union(){
cube([nema_xy+rabio,nema_xy+rabio,nema_z+rabio],center=true);
translate([0,0,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h,d=nema_cyl_d+rabio,center=true);
//translate([0,0,nema_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,r=nema_cyl_r,center=true);
for(i = [-1,1]){
    for(j = [-1,1]){
        translate([i*nema_vis_space,j*nema_vis_space,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h*2,d=3+rabio,center=true);
    }
}
}
}

module nema17_neg_cyl_only(rabio=0) {
translate([0,0,-nema_z/2-nema_axe_h/2])
union(){
translate([0,0,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h,d=nema_cyl_d+rabio,center=true);
//translate([0,0,nema_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,r=nema_cyl_r,center=true);
for(i = [-1,1]){
    for(j = [-1,1]){
        translate([i*nema_vis_space,j*nema_vis_space,nema_z/2+nema_axe_h/2]) cylinder(h=nema_axe_h*10,d=3+rabio,center=true);
    }
}
}
}

//nema17_neg();

// nema17_small: 
nema_xy = 42.3;
nema_small_z = 28;
nema_cyl_r = 11;
nema_cyl_h = 2;
nema_axe_r = 2.5;
nema_axe_small_h = 18;

module nema17_small() {
translate([0,0,-nema_small_z/2-nema_axe_small_h/2])
union(){
cube([nema_xy,nema_xy,nema_small_z],center=true);
translate([0,0,nema_small_z/2+nema_axe_small_h/2]) cylinder(h=nema_axe_small_h,r=nema_axe_r,center=true);
translate([0,0,nema_small_z/2+nema_cyl_h/2]) cylinder(h=nema_cyl_h,r=nema_cyl_r,center=true);
}
}
// lm6uu
lm6uu_ID = 6;
lm6uu_OD = 12;
lm6uu_z = 19;
module lm6uu(rabio=rabio){
cylinder(h=lm6uu_z+rabio,d=lm6uu_OD+rabio,center=true);
}
// lm8uu
lm8uu_ID = 8;
lm8uu_OD = 15;
lm8uu_z = 24;
module lm8uu(rabio=rabio){
cylinder(h=lm8uu_z+rabio,d=lm8uu_OD+rabio,center=true);
}

// machin6uu
machin6uu_ID = 6;
machin6uu_OD = 10;
machin6uu_z = 6;
module machin6uu(rabio=rabio,rabio_h = 0){
cylinder(h=machin6uu_z+rabio_h,d=machin6uu_OD+rabio,center=true);
}

// lm10uu
lm10uu_ID = 10;
lm10uu_OD = 19;
lm10uu_z = 29;
module lm10uu(rabio=rabio){
cylinder(h=lm10uu_z+rabio,d=lm10uu_OD+rabio,center=true);
}

// 608zz
608zz_ID = 8;
608zz_OD = 22;
608zz_z = 7;
module 608zz() {
difference(){
cylinder(h=608zz_z,r=608zz_OD/2,center=true);
//scylinder(h=608zz_z*2,r=608zz_ID/2,center=true);
}
}

// 604zz
604zz_ID = 4;
604zz_OD = 12;
604zz_z = 4;
module 604zz() {
difference(){
cylinder(h=604zz_z,r=604zz_OD/2,center=true);
cylinder(h=604zz_z*2,r=604zz_ID/2,center=true);
}
}

//seringe
syringe_body_h = 30;
syringe_body_r = 2;
syringe_piston_h = 30;
syringe_piston_r = 1;
syringe_needle_h = 20;
syringe_needle_r = 0.5;
syringe_grip_h = 1;
syringe_grip_r = 2;
module syringe() {
cylinder(h=syringe_needle_h,r=syringe_needle_r);
translate([0,0,syringe_needle_h]) cylinder(h=syringe_body_h,r=syringe_body_r);
translate([0,0,syringe_body_h+syringe_needle_h]) cylinder(h=syringe_piston_h,r=syringe_piston_r);
translate([0,0,syringe_body_h+syringe_needle_h+syringe_piston_h]) cylinder(h=syringe_grip_h,r=syringe_grip_r);
}

// vial: dim
N9_r = 11.6/2;
N9_h = 32;
module N9(rabio=rabio) {
cylinder(h=N9_h,d=N9_r*2+rabio,center=true);
}

// gt2 pulley

gt2_pulley_d = 15;
gt2_pulley_h = 14;
module gt2_pulley() {
    cylinder(d=gt2_pulley_d,h=gt2_pulley_h,center=true);
}

// endstop

endstop_x = 16;
endstop_y = 40;
endstop_z = 8;
endstop_d = 3.5;
endstop_out_x = 2;
endstop_out_y_1 = 2;
endstop_out_y_2 = 17;
endstop_out_y_3 = 36;
module endstop_neg() {
    union(){
        translate([endstop_x/2-endstop_out_x,endstop_y/2-endstop_out_y_1]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
        translate([-endstop_x/2+endstop_out_x,endstop_y/2-endstop_out_y_1]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
        translate([endstop_x/2-endstop_out_x,endstop_y/2-endstop_out_y_2]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
        translate([endstop_x/2-endstop_out_x,endstop_y/2-endstop_out_y_3]) cylinder(h=10*endstop_z,d=endstop_d,center=true);
    }
}
module endstop() {
    difference(){
        cube([endstop_x,endstop_y,endstop_z],center=true);
        endstop_neg();
    }
}

// coupler
coupler_d = 18;
coupler_h = 25;
module coupler(){
    translate([0,0,nema_axe_h/2]) cylinder(d=coupler_d,h=coupler_h,center=true);
}

// tr8
tr8_d = 8;
tr8_h=150;
tr8_nut_d1 = 22;
tr8_nut_d2 = 10;
tr8_nut_h1 = 3.5;
tr8_nut_h2 = 10;
tr8_nut_r = 8;
module tr8_nut(rabio=rabio){
    difference() {
        union(){
            translate([0,0,tr8_nut_h1/2+tr8_nut_d2]) cylinder(h=tr8_nut_h1,d=tr8_nut_d1,center=true);
            translate([0,0,tr8_nut_h2/2]) cylinder(h=tr8_nut_h2,d=tr8_nut_d2,center=true);
        }
        union(){
            translate([1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
            translate([-1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
            translate([0*tr8_nut_r,1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
            translate([0*tr8_nut_r,-1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        }
    }
}
module tr8_nut_neg(rabio=rabio){
    union(){
        //translate([0,0,tr8_nut_h1/2+tr8_nut_d2]) cylinder(h=tr8_nut_h1,d=tr8_nut_d1+rabio,center=true);
        translate([0,0,tr8_nut_h2/2]) cylinder(h=tr8_nut_h2*10,d=tr8_nut_d2+rabio,center=true);
        translate([1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        translate([-1*tr8_nut_r,0*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        translate([0*tr8_nut_r,1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
        translate([0*tr8_nut_r,-1*tr8_nut_r,0]) cylinder(h=100,d=3+rabio,center=true);
    }
}
module tr8(){
    cylinder(d=tr8_d,h=tr8_h);
}

power_supply_x = 67;
power_supply_y = 171;
power_supply_z = 42;
module power_supply(rabio=0){
    color("black") cube([power_supply_x,power_supply_y,power_supply_z],center=true);
}

inductif_d = 12;
inductif_z = 62;
module inductif_sensor(rabio=rabio){
    color("orange") cylinder(d=inductif_d+rabio,h=inductif_z);
}