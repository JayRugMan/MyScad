/********************************************/
/*     A plug for a hole with a wire        */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-11-27                 */
/*                                          */
/********************************************/

$fn = 500;

/* Layer Hieght at 0.12 MM */

/* Dimensions */
hole_diam = 19.45;
hole_depth = 8;

plug_outer_diam = hole_diam + 0.2;
wall_thickness = 1.4;
plug_inner_diam = plug_outer_diam - (2*wall_thickness);

cap_diam = hole_diam * 1.3; 
cap_lip_thkns = 3;

cable_run_length = (cap_diam/2 - plug_outer_diam/2) + wall_thickness;
cable_thickness = 4.8;
cable_run_height = hole_depth + cap_lip_thkns;


// Module Definitions

module dome(d=5, h=2, hollow=false, wallWidth=0.5, $fn=128) {
    // Created by Sembiance, found on Thingiverse at https://www.thingiverse.com/thing:2015387

	sphereRadius = (pow(h, 2) + pow((d/2), 2) ) / (2*h);
	translate([0, 0, (sphereRadius-h)*-1])
	{
		difference()
		{
			sphere(sphereRadius);
			translate([0, 0, -h])
			{
				cube([2*sphereRadius, 2*sphereRadius, 2*sphereRadius], center=true);
			}
			if(hollow)
				sphere(sphereRadius-wallWidth);
		}
	}
}


module cap(x=0, y=0, z=0) {
    // the cap

    translate([x, y, z]) {
        union() {
            linear_extrude(height = cap_lip_thkns) {
                circle( d = cap_diam );
            }
            translate([0,0,cap_lip_thkns]) {
                dome(d=cap_diam, h=4, $fn=500);
            }
        }
    }
}


module plug(x=0, y=0, z=0) {
    // the plug

    translate([x, y, z]) {
        difference() {
            linear_extrude( height = hole_depth ) {
                circle( d = plug_outer_diam );
            }
            translate([0, 0, -0.1]) {
                linear_extrude( height = (hole_depth + 0.2) ) {
                    circle( d = plug_inner_diam );
                }
            }
        }
    }
}


module cable_run(tx=0, ty=0, tz=0, rx=0, ry=0, rz=0) {
    // where the cable runs through

    translate([tx, ty - (cable_thickness/2), tz]) {
        rotate([rx, ry, rz]) {
            cube([cable_run_length + cable_thickness, cable_thickness, cable_run_height]);
        }
    }
}


// module calls
difference() {
    union() {
        plug();
        cap(z=hole_depth);
    }
    cable_run(tx=(plug_inner_diam/2 - cable_thickness));
}