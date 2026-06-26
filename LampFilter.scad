// =============================
// touch light difuser cover
// Optimized for transparent PLA Printing
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 300; // smooth surface quality

// dimensions
difdiam = 75; // diameter of the diffuser
diff_thickness = 1.66; // thickness
lip_outer_diameter = 70.75; // diameter of the lip
lip_inner_diameter = 68.32; // inner lip diameter
lip_height = 6; // how far the lip is extruded from the diffuser

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

module tabs() {
    // three 4.9 mm tabs in the lip where the gaps are every 120 degrees
    for (i = [0:2]) {
        rotate([0, 0, i * 120]) {
            translate([lip_outer_diameter / 2, 0, diff_thickness]) {
                cylinder(d = 4.9, h = lip_height);
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
            cylinder(d = lip_inner_diameter, h = lip_height + 1);
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
}

// display
filter();
cylinder_supports();