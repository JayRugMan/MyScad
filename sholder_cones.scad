// =============================
// Modular Clip-On Cone
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 200; // smooth surfaces

// ----- Cone with Clip Tabs -----
// Parameters:
//   d_base       : base diameter of cone (visible cone part)
//   h            : height of cone
//   x, y, z      : translation coordinates
//   d_clip_hole  : diameter of cardboard hole
//   tab_height   : height (thickness) of clip tabs
//   tab_count    : number of tabs
//   tab_flex_gap : small gap under tabs for flex (mm)
module clip_cone(
    d_base,
    h,
    x=0, y=0, z=0,
    d_clip_hole,
    tab_height=1.5,
    tab_count=4,
    tab_flex_gap=0.6
) {
    translate([x, y, z]) {
        // Main cone
        cylinder(h=h, r1=d_base/2, r2=1.5, center=false);

        // Shaft below cardboard (fits into hole)
        shaft_height = 2; // how far into cardboard it goes
        difference() {
            // Shaft cylinder
            cylinder(h=shaft_height + tab_height, r=d_clip_hole/2);
            // Clearance below tabs for flex
            translate([0,0,tab_height])
                cylinder(h=tab_flex_gap, r=d_clip_hole/2 + 0.3);
        }

        // Tabs around the shaft
        for (i = [0 : 360/tab_count : 360-360/tab_count]) {
            rotate([0,0,i])
                translate([d_clip_hole/2-.5, - 1.5, 0])
                    cube([1.6, 3, tab_height], center=false);
        }
    }
}

// ----- Example Usage -----

// Parameters
d_cardboard_hole = 82; // diameter of the hole in the cardboard

// Cone #1
clip_cone(
    d_base=82, h=90,
    d_clip_hole=d_cardboard_hole,
    x=0
);

// Cone #2 (side-by-side)
clip_cone(
    d_base=25, h=40,
    d_clip_hole=30,
    x=60
);
