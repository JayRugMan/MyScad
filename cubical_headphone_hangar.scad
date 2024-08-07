/********************************************/
/*     A jig for center of dehydrator       */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-05-08                 */
/*                                          */
/********************************************/

$fn = 500;


// Measurements

THICKNESS = 6;              // Thickness of the piece
RADIUS = THICKNESS/2;       // Radius of hanging edge

HOOK_DISTANCE = 50.5;       // The distance between the three hooks
HOOK_SPACE = 2.8;           // The space between hook and stem
HOOK_HEIGHT_A = 12.3;       // Hieght of entire hook
HOOK_HEIGHT_B = 6.5;        // Hieght of hook from space to top

HEIGHT = 112;               // Hieght of the piece
STEM_WIDTH = 12.2;          // Width of stem

TOP_LENGTH = 100.6;         // Total of the length of the hang
TOP_WIDTH = 23.5;           // Top Width
TOP_POSITION = 73.6;        // Position from zero of the top

SUPPORT_POSITION = 0;       // Position of the triangle support
SUPPORT_AB = 43;            // Short sides of support outter triange
SUPPORT_CUTOUT_AB = 27.9;   // Short sides of support internal triangle


// Modules and Functions

module hook(tx=0, ty=0, tz=0) {
    // Module for a hook
    translate([tx,ty,tz]) {
        union() {
            translate([0,HOOK_HEIGHT_A,RADIUS]) {
                rotate([90,0,0]) {
                    cylinder(h=HOOK_HEIGHT_A, r=RADIUS);
                }
            }
            translate([0,HOOK_HEIGHT_A-HOOK_HEIGHT_B,0]) {
                linear_extrude(height = THICKNESS) square([HOOK_SPACE, HOOK_HEIGHT_B], center=false);
            }
        }
    }
}

module stem(tx=0, ty=0, tz=0, rx=0, ry=0, rz=0) {
    // The stem is the section of the piece that hooks into the cubical
    translate([tx,ty,tz]) {
        linear_extrude(height = THICKNESS) square([STEM_WIDTH, HEIGHT], center=false);
    }
}

module top(tx=0, ty=0, tz=0) {
    // The top is the section of the piece upon which the headphones hang
    translate([tx,ty,tz]) {
        union() {
            linear_extrude(height = THICKNESS) square([TOP_LENGTH, TOP_WIDTH-RADIUS], center=false);
            translate([0,TOP_WIDTH-RADIUS,RADIUS]) {
                rotate([0,90,0]) {
                    cylinder(h=TOP_LENGTH, r=RADIUS);
                }
            }
        }
    }
}

module support(tx=0, ty=0, tz=0) {
    // Triangle supports
    translate([tx,ty,tz]) {
        difference() {
            linear_extrude(THICKNESS) polygon(points = [
                [0,0],
                [0,SUPPORT_AB],
                [SUPPORT_AB,SUPPORT_AB]
            ]);
            linear_extrude(THICKNESS) polygon(points = [
                [0,SUPPORT_AB-SUPPORT_CUTOUT_AB],
                [0,SUPPORT_AB],
                [SUPPORT_CUTOUT_AB,SUPPORT_AB]
            ]);
        }
    }
}


// Module Calls

*stem();
*top(ty=TOP_POSITION);
*support(tx=STEM_WIDTH,ty=TOP_POSITION-SUPPORT_AB);

hook();

*color("red") translate([105,TOP_POSITION,0]) {
    cube([THICKNESS,23.5,THICKNESS]);
}