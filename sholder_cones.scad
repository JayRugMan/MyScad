// =============================
// High-Resolution Modular Cones
// Compatible with OpenSCAD 2021.01
// =============================

// Global quality setting
$fn = 200; // Increase for smoother surfaces

// ----- Cone Module -----
// Parameters:
//   d_base : base diameter of the cone
//   h      : height of the cone
//   x, y, z: position coordinates
module cone(d_base, h, x=0, y=0, z=0) {
    translate([x, y, z])
        cylinder(h=h, r1=d_base/2, r2=3, center=false);
}

// ----- Example Usage -----

// First cone: base diameter 40mm, height 60mm, placed at origin
cone(d_base=82, h=90);

// Second cone: base diameter 25mm, height 40mm, shifted along X axis
cone(d_base=25, h=40, x=60);
