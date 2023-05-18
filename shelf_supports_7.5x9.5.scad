/********************************************/
/*    Support for a shelf 12 in or less     */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-05-17                 */
/*                                          */
/********************************************/


/* args */
$fn = 100;
layer_h = 0.12; // mm
line_t = 0.4; // mm
thickness = 25.32;  // overall thickness of the support bracket
long_side = 241.3;  // the long side of the support bracket
short_side = 190.5;  // the short side of the support bracket
side_co_yoffset = 12;  // the depth of the side cutouts
side_co_xoffset = side_co_yoffset * (short_side/long_side);  // the depth of the side cutouts




/* Module definitions */


module volume_cube() {
  // The volume of the build space (Ender 5 Pro)
  color("red") {
    linear_extrude(height = 2490 * layer_h) {  // 298.8 mm
      square(size = 196, center = false);
    }
  }
}


module screw_hole(the_x=0, the_y=0, the_z=0, length=10, y_rot=0){
  rad_1 = 1.9;
  rad_2 = 3.4;
  screw_head_width = 2.3;
  shaft_hole = length - screw_head_width;
  translate([the_x, the_y, the_z]){
    rotate([0,y_rot,0]){
      union() {
        cylinder(h = shaft_hole+0.12, r = rad_1);
        translate([0,0,shaft_hole]) cylinder(h = screw_head_width, r1 = rad_1, r2 = rad_2);
      }
    }
  }
}


module base_triangle(t_x=0, t_y=0, t_z=0, the_points=[[0,0], [0,1], [1,0]], the_thick=1) {

  translate([t_x, t_y, t_z]) {
    linear_extrude( height = the_thick ) {
      polygon(points = the_points);
    }
  }
}


module full_cutout() {
  union() {

    base_triangle(  // cutout a (side)
      t_x=side_co_xoffset, t_y=side_co_yoffset, t_z=-1,
      the_points=[
        [0,0],[0,long_side-(side_co_yoffset*2)],[short_side-(side_co_xoffset*2),0]
      ],
      the_thick=(thickness/3)+1
    );

    base_triangle(  // cutout b (center)
      t_x=side_co_xoffset, t_y=side_co_yoffset, t_z=(thickness/3)-2, 
      the_points=[
        [0,0],[0,long_side-(side_co_yoffset*4)],[short_side-(side_co_xoffset*4),0]
      ],
      the_thick=(thickness/3)+4
    );

    base_triangle(  // cutout c (side)
      t_x=side_co_xoffset, t_y=side_co_yoffset, t_z=(2*(thickness)/3)+1, 
      the_points=[
        [0,0],[0,long_side-(side_co_yoffset*2)],[short_side-(side_co_xoffset*2),0]
      ],
      the_thick=(thickness/3)+1
    );

  }
}


module final(tr_x=0, tr_y=0, tr_z=0, r_x=0, r_y=0, r_z=0) {
  translate([tr_x, tr_y, tr_z]) {
    rotate([r_x, r_y, r_z]) {
      difference() {
        base_triangle(the_points=[[0,0],[0,long_side],[short_side,0]], the_thick=thickness);
        translate([1.2,1.2,0]) {
          full_cutout();
        }
      }
    }
  }
}


/* Module calls */
*volume_cube();
difference() {
  final(r_x=90, tr_y=thickness);
  screw_hole(the_x=-1.2, the_y=(thickness/4), the_z=long_side/4, length=side_co_xoffset+2.6, y_rot=90);
  screw_hole(the_x=-1.2, the_y=(thickness*3/4), the_z=long_side/2, length=side_co_xoffset+2.6, y_rot=90);
  screw_hole(the_x=-1.2, the_y=(thickness/4), the_z=long_side*3/4, length=side_co_xoffset+2.6, y_rot=90);
  screw_hole(the_x=short_side/3, the_y=(thickness*3/4), the_z=-1.2, length=side_co_yoffset+2.6);
  screw_hole(the_x=short_side*2/3, the_y=(thickness/4), the_z=-1.2, length=side_co_yoffset+2.6);
}
