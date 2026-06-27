// =============================
// touch light difuser cover
// Optimized for transparent PLA Printing
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 300; // smooth surface quality

// dimensions
difdiam = 75; // diameter of the diffuser
diff_thickness = 0.6; // thickness
lip_outer_diameter = 70.75; // diameter of the lip
lip_inner_diameter = 68.32; // inner lip diameter
lip_height = 6; // how far the lip is extruded from the diffuser
clip_width = 4.98; // width of the clip that holds the diffuser in place
clip_thickness = 1.54; // thickness of the clip that holds the diffuser in place
clip_height = lip_height; // height of the clip that holds the diffuser in place (same as lip height)
clip_tab_len = 3; // overhanging tab of clip
clip_tab_thickness = 1.6; // thickness of the overhanging tab of clip

// modules
module diffuser() {
    cylinder(d = difdiam, h = diff_thickness);
}

module cylinder_supports() {
    // three 1.4MM cylindars paced every 120 degrees around the lip
    for (i = [0:2]) {
        rotate([0, 0, i * 120 + 60]) {
            translate([lip_outer_diameter / 2, 0, diff_thickness]) {
                cylinder(d = 1.4, h = lip_height);
            }
        }
    }
}

module clips() {
    // three clips that hold the diffuser in place rotated and translated to the center of the lip gaps
    for (i = [0:2]) {
        rotate([0, 0, i * 120 + (-4)]) {
            translate([lip_outer_diameter / 2 - clip_thickness, 0, diff_thickness]) {
                cube([clip_thickness, clip_width, clip_height]);
                // clip top
                translate([0, clip_width, clip_height-clip_tab_thickness])
                    rotate([90, 0, 0])
                    linear_extrude(height = clip_width) {
                        polygon(points=[
                            [0,0],
                            [clip_thickness,0],
                            [clip_tab_len, 0.5],
                            [clip_tab_len,0.9],
                            [2,clip_tab_thickness],
                            [0,clip_tab_thickness]
                            ]
                        );
                    }
            }
        }
    }
}

module lip_gaps() {
    // three 7.4 mm gaps in the lip every 120 degrees opposite cylinder supports
    for (i = [0:2]) {
        rotate([0, 0, i * 120]) {
            translate([lip_outer_diameter / 2, 0, 0]) {
                cylinder(d = 7.4, h = lip_height + 1);
            }
        }
    }
}

module lip() {
    difference() {
        cylinder(d = lip_outer_diameter, h = lip_height);
        translate([0, 0, -0.5]) {cylinder(d = lip_inner_diameter, h = lip_height + 1);}
    }
}

module filter() {
    diffuser();
    translate([0, 0, diff_thickness]) 
    //lip with gaps ()difference
    difference() {
        lip();
        lip_gaps();
    }
    // clip rotated and translated to the center of the lip gaps
    clips();
    // Cylinder supports
    cylinder_supports();
}

// display
*diffuser();
*cylinder_supports();
*clips();
*lip_gaps();
*lip();
filter();
