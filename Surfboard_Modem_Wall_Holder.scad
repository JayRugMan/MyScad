/********************************************/
/*    Surfboard Modem Wall-Mounted Shelf    */
/*                                          */
/*        Created by Jason Hardman          */
/*               2022-05-22                 */
/*                                          */
/********************************************/


/* Variables */
$fn = 100;

/* surfboard dementions */
the_height = 134;  // A/Y
the_width = 132;   // C/Z
the_depth = 45;    // B/X

/* shelf args */
thickness = 5;
back_height_offset = 45;
front_height_offset = 35;


/* Module definitions */
module the_surf(the_x=0, the_y=0, the_z=0){
  translate([the_x, the_y, the_z]){
    rotate([0,0,0]){
      cube([the_depth, the_height, the_width]);  // The bottom of the router is sitting on the x/z plane while the wall is the y/z plane
    }
  }
}


module support(the_x=0, the_y=0, the_z=0){
  translate([the_x, the_y, the_z]){
    rotate([0,0,0]){
      linear_extrude(thickness){
        polygon([
          [thickness, 20 + thickness],
          [the_depth/2 + thickness, 10 + thickness],
          [the_depth + thickness, 20 + thickness],
          [the_depth + thickness,thickness],
          [thickness,thickness],
        ]);
      }
    }
  }
}


module screw_hole(the_x=0, the_y=0, the_z=0){
  rad_1 = 1.9;
  rad_2 = 3.4;
	length = thickness;
  screw_head_width = 2.3;
  shaft_hole = length - screw_head_width;
  translate([the_x, the_y, the_z]){
    rotate([0,90,0]){
      union() {
        cylinder(h = shaft_hole, r = rad_1);
        translate([0,0,shaft_hole]) cylinder(h = screw_head_width, r1 = rad_1, r2 = rad_2);
      }
    }
  }
}


module the_shelf(){
  linear_extrude(the_width + (thickness*2)){
    polygon([
      [0,the_height + thickness - back_height_offset],
      [0,0],
      [the_depth + (thickness*2),0],
      [the_depth + (thickness*2),front_height_offset],
      [the_depth + thickness,front_height_offset],
      [the_depth + thickness,thickness],
      [thickness,thickness],
      [thickness,the_height + thickness - back_height_offset]
    ]);
  }
}


/* Module calls */
*color("white", 0.9){the_surf(thickness, thickness, thickness);}
difference(){
  union(){
    color("blue"){
      the_shelf();
      support();
      support(the_z=(the_width + thickness));
    }
  }
  screw_hole(the_y = 40,
             the_z = the_width/2 + thickness);
  screw_hole(the_y = 80,
             the_z = the_width/2 + thickness);
}

*screw_hole();