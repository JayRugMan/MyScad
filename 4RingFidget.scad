// =============================
// 4 Ring Fidget Toy
// Optimized for transparent PLA Printing
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 300; // smooth surface quality

// ring parameters
ring_thickness = 9.1; // thickness of the ring
squash_1 = 0.5; // squash for better bulge
squash_2 = 0.62; // squash for better bulge
squash_3 = 0.73; // squash for better bulge
squash_4 = 0.95; // squash for better bulge

// modules

module ring(inner_diameter, outer_diameter, squash_factor) {
    intersection() {
        difference() {
            // outer sphere
            scale([1, 1, squash_factor]) sphere(d=outer_diameter);
            // inner sphere
            scale([1, 1, squash_factor]) sphere(d=inner_diameter);
        }
        // slice
        cube([outer_diameter + 1, outer_diameter + 1, ring_thickness], center=true);
    }
}

// display
ring(40, 45.5, squash_1);
ring(31.4, 36.9, squash_2);
ring(23.5, 29, squash_3);
ring(0, 20.73, squash_4);
