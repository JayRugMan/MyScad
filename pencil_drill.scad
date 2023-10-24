/********************************************/
/*     Shop Pencil Sharpening Lathe Bit     */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-10-21                 */
/*                                          */
/********************************************/


/*  Definitions  */
$fn = 500;

BUFFER_SPACE = 0.2;

// Pencil Dimentions of Pencil Laying Flat (millimeters)
PENCIL_X = 175;                           // Pencil Length
PENCIL_Y = 13.9 + BUFFER_SPACE;           // Pencil Width (thickest)
PENCIL_Z = 7.55 + BUFFER_SPACE;           // Pencil Width (thinnest)
CHAMFER_DIST = 12 + BUFFER_SPACE;       // distance between Chamfer planes

// Lathe Bit Dimentions
// Pencil Part
LB_X = PENCIL_Z + 10;
LB_Y = PENCIL_Y + 10;
LB_Z = 35;
// Drill Part
COLET_DPTH = 24;
COLET_DIAM = 12;
COLET_GAP = 0.8;
BIT_LANS_DIST = (COLET_DIAM - COLET_GAP);
// Collar
COLL_DEPTH = 10;
UPPER_LANS_DIST = LB_X;



/*  Modules  */
module pencil(t_x=0, t_y=0, t_z=0,
              r_x=0, r_y=0, r_z=0) {
    // Defines the pencil. Takes postion args for translation

    // Some maths
    chamf_diag = sqrt( 2 * (CHAMFER_DIST)^2 );
    diag_translation = chamf_diag/2;
    diag_trans_y = PENCIL_Y/2;
    diag_trans_z = diag_translation - PENCIL_Z/2;

    translate([t_x, t_y, t_z]){
        rotate([r_x, r_y, r_z]){
            intersection() {
                translate([-0.5,diag_trans_y,-diag_trans_z]) {  // x is -0.5 to buffer plane-intersection error in intersection function
                        rotate([45,0,0]) {
                        color("orangered", 1.0) {cube([PENCIL_X+1, CHAMFER_DIST, CHAMFER_DIST]);}
                    }
                }
                color("orangered", 1.0) {cube([PENCIL_X, PENCIL_Y, PENCIL_Z]);}
            }
        }
    }
}


module lathe_bit(t_x=0, t_y=0, t_z=0) {
    // Drill meets pencil to lathe in pencil sharpener

    // Pencil Holder
    translate([0,0,LB_Z+COLL_DEPTH]) {
        difference() {
            translate([t_x, t_y, t_z]) {
                cube([LB_X, LB_Y, LB_Z]);
            }
            pencil(r_y=-90,
                t_x=(PENCIL_Z/2)+(LB_X/2),
                t_y=(LB_Y/2)-(PENCIL_Y/2),
                t_z=10
            );
        }
    }

    // Collar
    translate([LB_X/2, LB_Y/2, LB_Z]) {
        linear_extrude(height = COLL_DEPTH, scale = 1.584821429, $fn = 16) {circle(d=BIT_LANS_DIST, $fn=6);}
    }

    // Drill Insert
    translate([LB_X/2, LB_Y/2, 0]) {
        linear_extrude(LB_Z) {
            circle(d=BIT_LANS_DIST, $fn=6);  // cricle becomes hexagon
        }
    }
}


/*  Function Calls  */
*pencil(r_y=-90,
       t_x=(PENCIL_Z/2)+(LB_X/2),
       t_y=(LB_Y/2)-(PENCIL_Y/2),
       t_z=10
);
color("white", 1.0) {lathe_bit();}