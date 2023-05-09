/********************************************/
/*     A jig for center of dehydrator       */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-05-08                 */
/*                                          */
/********************************************/

$fn = 500;

/* Layer Hieght at 0.12 MM */

/* Tray Dimensions */
t_diameter = 32;


module base_circle(x=0, y=0, z=0) {
    // base circle

    b_diam = 60;

    linear_extrude(height = 1.44) {
        circle( d = b_diam );
    }
}


module top_circle(x=0, y=0, z=0) {
    // main circle

    tc_diam = t_diameter;
    pin_diam = 3.2;
    pin_len = 11.4;

    difference() {
        linear_extrude( height = 26.4 ) {
            circle( d = tc_diam );
        }
        translate([0, 0, (26.4 - pin_len)])  linear_extrude( height = pin_len ) {
            circle( d = pin_diam );
        }
    }
}


top_circle();
base_circle();