fn = 100;

scale_factor = 0.1;
surface_file = "initials_5.png";

module initials() {
//  translate([18,-47,30]) 
//  rotate([65,0,270])
  difference() {
      scale([scale_factor,scale_factor,scale_factor+0.24]) {
        surface(file = surface_file, center = true, invert = false, convexity = 5);
        linear_extrude(height = 0.6) { 
          square([124,87], center = true);
        }
      }
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
  scale([3,3,3])
  rotate([r,180,180])
  linear_extrude(height=30, scale=[1,0.1], slices=500, twist=0)
  polygon(points=[[-20,0],[20,10],[20,-10]]);
};

*difference() {
  stand();
  center_cutout(10,-30,95,0);
  center_cutout(10,10,0,180);
  center_cutout(10,-70,0,180);
  initials();
}

initials();



