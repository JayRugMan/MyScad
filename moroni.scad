// =============================
// SimpleMoroni to shrink for small temples
// Optimized for transparent PLA Printing
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 300; // smooth surface quality
//An angel would be 9 heads high
head_height = 1; // average human head height in meters
head_width = head_height * (2/3); // average human head width in meters
head_thickness = head_width * 1.8; // average human head thickness in meters
body_height = head_height * 7; // minus the head height, so 8 heads for the body
body_width = head_width * 3.2; // average human body width in meters
body_thickness = body_width/1.8; // average human body thickness in meters
arm_length = head_height * 3.5; // average human arm length in meters
arm_width = head_width/2; // average human arm width in meters
trumpet_length = head_height * 7; // average trumpet length in meters
trumpet_width = head_width/3; // average trumpet width in meters

// Modules

module head() {
    // average human dimentions for a simple head as a cube
    translate([0, body_width/2 - head_width/2, 0]) {
        cube([head_thickness, head_width, head_height + body_height]);
    }
}

module body() {
    // average human dimentions for a simple as a cube
    translate([0, 0, 0]) {
        translate([0, 0, 0]) {
            rotate([90, 0, 90]) {
                color("red") linear_extrude(height=body_thickness) polygon(
                    points=[
                        [0, body_height], // left shoulder
                        [body_width, body_height], // right shoulder
                        [body_width/2, 0], // right hip
                        [body_width/2, 0] // left hip
                    ]
                );
            }
        }
    }
}

module arm() {
    // average human dimentions for a simple arm as a cylinder from body to middle of trumpet
    translate([head_thickness/2, arm_width/2, body_height-head_height/2]) {
        rotate([62, 0, 106]) {
            cylinder(r=arm_width, h=arm_length, center=false);
        }
    }
}

module trumpet() {
    // average human dimentions for a simple trumpet as a simple cylinder going from the mouth out straight, held by the hand in the middle
    translate([body_thickness, body_width/2, body_height + head_height/3]) {
        rotate([70, 0, 90]) {
            cylinder(r=trumpet_width, h=trumpet_length);
        }
    }
}

module moroni() {
    head();
    body();
    arm();
    trumpet();
}

// calls

moroni();