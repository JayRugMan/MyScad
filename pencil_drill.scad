/********************************************/
/*     Shop Pencil Sharpening Lathe Bit     */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-10-21                 */
/*                                          */
/********************************************/


/*  Definitions  */
$fn = 500;

BUFFER_SPACE = 0.8;

// Pencil Dimentions of Pencil Laying Flat (millimeters)
PENCIL_X = 175;            // Pencil Length
PENCIL_Y = 13.9 + BUFFER_SPACE;           // Pencil Width (thickest)
PENCIL_Z = 7.55 + BUFFER_SPACE;           // Pencil Width (thinnest)
CHAMFER_CUTOUT = 12 + BUFFER_SPACE;     // distance between Chamfer planes

// Lathe Bit Dimentions
LB_X = PENCIL_Z + 10;
LB_Y = PENCIL_Y + 10;
LB_Z = 35;


/*  Modules  */
module pencil(t_x=0, t_y=0, t_z=0,
              r_x=0, r_y=0, r_z=0) {
    // Defines the pencil. Takes postion args for translation

    // Some maths
    chamf_diag = sqrt( 2 * (CHAMFER_CUTOUT)^2 );
    diag_translation = chamf_diag/2;
    diag_trans_y = PENCIL_Y/2;
    diag_trans_z = diag_translation - PENCIL_Z/2;

    translate([t_x, t_y, t_z]){
        rotate([r_x, r_y, r_z]){
            intersection() {
                translate([-0.5,diag_trans_y,-diag_trans_z]) {
                        rotate([45,0,0]) {
                        color("orangered", 1.0) {cube([PENCIL_X+1, CHAMFER_CUTOUT, CHAMFER_CUTOUT]);}
                    }
                }
                color("orangered", 1.0) {cube([PENCIL_X, PENCIL_Y, PENCIL_Z]);}
            }
        }
    }
}


module lathe_bit(t_x=0, t_y=0, t_z=0) {
    // Drill meets pencil to lathe in pencil sharpener

    translate([t_x, t_y, t_z]) {
        color("white", 1.0) {cube([LB_X, LB_Y, LB_Z]);}
    }
}


/*  Function Calls  */
pencil(r_y=-90,
       t_x=(PENCIL_Z/2)+(LB_X/2),
       t_y=(LB_Y/2)-(PENCIL_Y/2),
       t_z=10
);
lathe_bit();