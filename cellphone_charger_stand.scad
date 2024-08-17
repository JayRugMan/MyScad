fn = 100;

scale_factor = 0.02;
surface_file = "initials_7.png";

module initials(tx=0, ty=0, tz=0, rx=0, ry=0, rz=0) {
  translate([tx,ty,tz+2.99]) 
  rotate([rx,ry,rz])
  difference() {
    scale([scale_factor,scale_factor,scale_factor+0.01]) {
      surface(file = surface_file, center = true, invert = true, convexity = 5);
    }
    translate([0,0,-0.02]) cube([12.5,8.75,0.06], center=true);
  }
}

module stand() {
  rotate([90,0,0])
  linear_extrude(60) {
    polygon([[-9,8],[2,0],[6,0],[46,82],[66,0],[69,0],[49,86],[44,86],[4,3],[3,3],[-7,10]]);
  }
};

module center_cutout(x, y, z, r) {
  translate([x, y, z])
  scale(3)
  rotate([r,180,180])
  linear_extrude(height=30, scale=[1,0.1], slices=500, twist=0)
  polygon(points=[[-20,0],[20,10],[20,-10]]);
};

difference() {
  stand();
  center_cutout(10,-30,95,0);
  center_cutout(10,10,0,180);
  center_cutout(10,-70,0,180);
  initials(20,-47,30,115.5,0,90);  //initials(16.5,-47,30,65,0,270);
}

*initials(16.5,-47,30,125,0,90);
*color("red") translate([0,0,-0.02]) cube([12.5,8.75,0.06], center=true);