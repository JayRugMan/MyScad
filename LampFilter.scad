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

module lip() {
    translate([0, 0, diff_thickness])
    difference() {
        cylinder(d = lip_outer_diameter, h = lip_height);
            cylinder(d = lip_inner_diameter, h = lip_height + 1);
    }
}

// display
diffuser();
lip();