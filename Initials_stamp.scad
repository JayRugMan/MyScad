$fn = 500;

scale_factor = 0.1;
surface_file = "initials_5.png";

module initials() {
  translate([0,0,1]) 
  scale([scale_factor,scale_factor,scale_factor+0.24]) 
  rotate([180,0,0])
  mirror([0,0,1])
  surface(file = surface_file, center = true, invert = true, convexity = 5);
}

module sleeve() {
  translate([0,0,-0.3])
  difference() {
    cylinder(h = 0.5, r = 10);
    translate([0,0,-0.01]) cylinder(h = 0.52, r = 8);
  }
}

module the_rim() {
  difference() {
    cylinder(h = 1.133, r = 8);
    cube([12.3,8.6,2.29], center = true);
    //translate([0,0,-0.01]) cylinder(h = 0.98, r = 7.6);
  }
}

module mid_cyl() {
  translate([0,0,-10])
  cylinder(h = 10, r1 = 5, r2 = 8);
}

module the_handle() {
  translate([0,0,-40])
  cylinder(h = 30, r = 5);
}

module the_stamp() {
  //difference() {initials(); sleeve();}
  initials();
  the_rim();
  mid_cyl();
  the_handle();
}

translate([0,0,40]) the_stamp();