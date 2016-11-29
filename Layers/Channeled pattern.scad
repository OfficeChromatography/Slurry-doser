

width = 2;
height = 100;
gap = 2;
thick = 0.2;
nbr = 24;

for(i = [1:1:nbr]){
    translate([i*(width+gap),0,0]) cube([width,height,thick],center=true);
}
