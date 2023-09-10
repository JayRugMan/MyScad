/********************************************/
/*       A center for the dehydrator        */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-05-10                 */
/*                                          */
/********************************************/

$fn = 500;

/*** Layer Hieght at 0.12 mm ***/
/*** Extrusion Thickness at 0.4 mm ***/


/* Tray Dimensions */
t_outer_diameter = 240;  // tray outer diameter

t_i_diameter = 33.6;  // tube inner diameter
t_b_o_diameter = 40.4;  // tube base outer daimeter
t_t_o_diamter = 38.4;  // tube top outer diameter
t_depth = 16.68;  // depth of the inner tray tube

t_thickness = 28.2;  // tray thickness (bottom plus sides)
t_bed_thickness = 1.32;  // thickness of the tray bottom
t_stack_depth = 81.72;  // stacked tray depth to lid
t_wall_thickness = 2.8;  // tray wall thickness

t_l_dip = 10.32;  // t_lid_dip


/* Spool Dimensions */
sp_thickness = 66.84;  // spool thickness
sp_outer_diameter = 199.2;  // outer diameter
sp_c_h_diameter = 56.4;  // center hole diameter
sp_fillament_diameter = 150;  // diameter of the fillament
sp_f_thickness = 2.64;  // flang thickness


/*** Modules ***/
module tray(x=0, y=0, z=0) {

    difference() {
        cylinder(h = t_depth, d1 = t_b_o_diameter, d2 = t_t_o_diamter);
        translate([0, 0, -0.5]) {
            cylinder(h = t_depth + 1, d = t_i_diameter);
        }
    }

    difference() {
        linear_extrude(height = t_stack_depth) {
            circle( d = t_outer_diameter );
        }
        translate([0, 0, (t_bed_thickness)]) {
            linear_extrude( height = ( t_stack_depth - t_bed_thickness ) + 1 ) {
                circle( d = ( t_outer_diameter - (t_wall_thickness * 2 ) ) );
            }
        }
        cylinder(h = t_bed_thickness + 1, d = t_i_diameter);
    }
}


module spool(t_x=0, t_y=0, t_z=0) {
    translate([t_x, t_y, t_z]) {
        difference() {
            difference() {
                cylinder(h = sp_thickness, d = sp_outer_diameter);
                translate([0, 0, sp_f_thickness]) {
                    difference() {
                        cylinder(h = (sp_thickness - (sp_f_thickness * 2) ), d = (sp_outer_diameter + 1));
                        cylinder(h = (sp_thickness - (sp_f_thickness * 2) ), d = sp_fillament_diameter);
                    }
                }
            }
            translate([0, 0, -0.5]) {
                cylinder(h = sp_thickness + 1, d = sp_c_h_diameter);
            }
        }
    }
}


module center_print(t_x=0, t_y=0, t_z=0) {
    max_gap = ( t_stack_depth - (t_bed_thickness + t_l_dip + 0.24) );
    inlay_length = 14.8;  // How deep into the cylinder does cutout go?
    //inlay_diameter = t_t_o_diamter + 1.2;
    inlay_diameter = t_b_o_diameter + .4;

    center_hole_diameter = t_i_diameter;
    tube_diameter = sp_c_h_diameter - 5.08;

    the_length = max_gap - (t_depth - inlay_length);

    color("DarkSlateGray") {
        translate([t_x, t_y, t_z]) {
            difference() {
                cylinder(h = the_length, d = tube_diameter);
                translate([0, 0, -0.5]) {
                    union() {
                        cylinder(h = (the_length + 1), d = center_hole_diameter);
                        cylinder(h = (inlay_length + 0.5), d = inlay_diameter);
                    }
                }
            }
        }
    }
}


module cutaway() {
    *spool(t_z=t_bed_thickness);
    difference() {
        union() {
            tray();
            center_print(t_z=(t_depth - 14.8));
        }
        rotate([0, 0, 90]) {
            translate([-120, 0, -1]) {
                cube([240, 130, 100]);
            }
        }
    }
}


/*** Module Calls ***/
*cutaway();
center_print();