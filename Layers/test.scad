// File to test the printer, i. e. the Z level, optimize the Z offset in slic3r afterward or the position of the inductif sensor
// a sheet of paper should be put between the needle and glass plate, no more, no less


difference(){
    cube([80,80,0.2],center=true);
    cube([78,78,0.3],center=true);
}
