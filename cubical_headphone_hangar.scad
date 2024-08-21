/********************************************/
/*     A jig for center of dehydrator       */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-05-08                 */
/*                                          */
/********************************************/

$fn = 100;

scale_factor = 0.02;
surface_file = "initials_7.png";

// Measurements

THICKNESS = 5.2;                                  // Thickness of the piece
RADIUS = THICKNESS/2;                             // Radius of hanging edge

HOOK_SPACING = 44.4;                              // The space between top of hook and bottom of next hook
HOOK_ATTA_HEIGHT = 6.3;                           // Hieght of where the hook attaches to the stem
HOOK_DISTANCE = HOOK_SPACING + HOOK_ATTA_HEIGHT;  // The distance between the three hooks
HOOK_SPACE = 2.8;                                 // The space between hook and stem
HOOK_HEIGHT = 12;                                 // Hieght of entire hook
HOOK_CONE_H = 3;

HEIGHT = 114.1;                                   // Hieght of the piece
STEM_WIDTH = 12.2;                                // Width of stem

TOP_LENGTH = 100.6;                               // Total of the length of the hang
TOP_WIDTH = 23.5;                                 // Top Width
TOP_POSITION = 73.6;                              // Position from zero of the top

SUPPORT_POSITION = 0;                             // Position of the triangle support
SUPPORT_AB = 43;                                  // Short sides of support outter triange
SUPPORT_CUTOUT_AB = 27.9;                         // Short sides of support internal triangle


// Modules and Functions

module initials(tx=0, ty=0, tz=0, rx=0, ry=0, rz=0) {
  translate([tx,ty,tz+2.99]) 
  rotate([rx,ry,rz])
  difference() {
    scale([scale_factor,scale_factor,scale_factor+0.01]) {
      surface(file = surface_file, center = true, invert = true, convexity = 5);
    }
    translate([0,0,-0.02]) cube([12.5,8.75,0.06], center=true);
  }
}

module hook(tx=0, ty=0, tz=0) {
    // Module for a hook
    translate([tx,ty,tz]) {
        union() {
            translate([0,0,RADIUS]) {
                rotate([270,0,0]) {
                    union() {
                        cylinder(h=HOOK_HEIGHT-HOOK_CONE_H, r=RADIUS);}
                        translate([0,0,-HOOK_CONE_H]) {cylinder(h=HOOK_CONE_H, r1=0.4, r2=RADIUS);
                    }
                }
            }
            translate([0,HOOK_HEIGHT-(HOOK_ATTA_HEIGHT+HOOK_CONE_H),0]) {
                linear_extrude(height = THICKNESS) square([RADIUS+HOOK_SPACE, HOOK_ATTA_HEIGHT], center=false);
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

stem();
difference() {
   top(ty=TOP_POSITION);
   initials(50,86,1,0,180,0);
}
support(tx=STEM_WIDTH,ty=TOP_POSITION-SUPPORT_AB);
for (i = [0:HOOK_DISTANCE:120]) {
    hook(tx=-HOOK_SPACE-RADIUS,ty=i);
}

*color("red") translate([-HOOK_SPACE,HOOK_HEIGHT-(HOOK_ATTA_HEIGHT+HOOK_CONE_H),THICKNESS-1]) {
    cube([HOOK_SPACE,HOOK_DISTANCE,THICKNESS/2]);
}

*hook();