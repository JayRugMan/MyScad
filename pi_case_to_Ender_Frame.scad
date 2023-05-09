
/********************************************/
/*    Raspberry Pi Mount to Ender 5 pro     */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-05-01                 */
/*                                          */
/********************************************/

include <pi_boards.scad>;


/*** Variables ***/
$fn = 500;

/* Pi Dimensions */
pi_x = 56;
pi_y = 85;

/* Case Dimensions */
bottom_thickness = 2;
wall_thickness = 2;
x_dimension = pi_x + (wall_thickness * 2);
y_dimension = pi_y + (wall_thickness * 2);

/* Position Variables */
pi_lift = bottom_thickness + 2;


/*** Function Definitions ***/
module bottom(x=0, y=0, z=0) {
  translate([x, y, z]){ 
    linear_extrude(height = bottom_thickness)
      square([x_dimension, y_dimension], center=false);
  }
}


/*** Function Calls ***/
bottom();
board_raspberrypi_3_model_b( the_x = (wall_thickness) , the_y = (wall_thickness), the_z=pi_lift);