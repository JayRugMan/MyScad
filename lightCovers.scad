// =============================
// Light Colors
// Optimized for transparent PLA Printing
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 300; // smooth surface quality

// slicer settings
layer_height = 0.2; // layer height for printing
line_width = 0.42;  // line width for printing
wall_count = 4;     // number of walls for strength

// Light Dimensions
light_diameter = 81.942; // diameter of the light rounded up to the nearest 0.2 mm
light_height = 58.6;    // height of the light

// Cover Dimensions
interface_buffer = 0.6; // buffer space between the light and the cover for easy installation
cover_thickness_side = wall_count * line_width; // thickness of the cover in mm
cover_thickness_top = wall_count * 2 * layer_height; // thickness of the cover in mm
cover_inner_diameter = light_diameter + 2 * interface_buffer; // inner diameter of the cover
cover_diameter = cover_inner_diameter + 2 * cover_thickness_side; // diameter of the cover
cover_height = light_height + cover_thickness_top + interface_buffer; // height of the cover

// Main Cover
module light_cover() {
    difference() {
        // Outer Shell
        cylinder(h = cover_height, d = cover_diameter, center = false);
        // Inner Cavity
        translate([0, 0, cover_thickness_top])
            cylinder(h = light_height + 2 * interface_buffer, d = cover_inner_diameter, center = false);
    }
}

// Generate the cover
light_cover();