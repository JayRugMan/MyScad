/********************************************/
/* A jig for low-voltage wall outlet mounts */
/*                                          */
/*        Created by Jason Hardman          */
/*               2022-05-21                 */
/*                                          */
/********************************************/


$fn = 100;
the_depth = 5.2;
bev_rad = 1.495;
bev_dia = bev_rad * 2;
hole_w = 54.6;
hole_h = 91.78;
boarder = 10;
brdr_offst = boarder * 2;
boarder_w = brdr_offst+hole_w;
boarder_h = brdr_offst+hole_h;


/* Module definitions */
module the_hole(the_x=0, the_y=0, the_z=0) {
  translate([the_x+bev_rad, the_y+bev_rad, the_z]) {
    minkowski(){
      cube([ (hole_w-bev_dia), (hole_h-bev_dia), the_depth]);
      cylinder(r=bev_rad, h=the_depth);
    }
  }
}


module the_boarder(the_x=0, the_y=0, the_z=0) {
  translate([the_x, the_y, the_z]) {
    cube([boarder_w, boarder_h, the_depth]);
  }
}


/* Module calls */
difference() {
  the_boarder(the_x=-(boarder_w/2), the_y=-(boarder_h/2));
  the_hole(the_x=-(hole_w/2), the_y=-(hole_h/2));
}


*translate([0,0,6]){
  color("red") {square([hole_w,hole_h], center = true);}
}