// =============================
// Clip-On Cone (Supportless Transition)
// Optimized for PLA Printing
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 300; // smooth surface quality

// ----- Clip-On Cone Module -----
// Parameters:
//   d_base             : base diameter of visible cone
//   h                  : height of visible cone
//   x, y, z            : translation coordinates
//   d_clip_hole        : hole diameter in cardboard
//   cardboard_thickness: thickness of cardboard (gap between posts)
//   post_height_above  : post section above cardboard
//   post_height_below  : post section below cardboard
//   tab_height         : vertical height of each tab
//   tab_width          : width of each tab (around tangent)
//   tab_depth          : radial protrusion of each tab
//   tab_count          : number of tabs
//   transition_height  : height of the tapered neck between post & cone
module clip_cone(
    d_base,
    h,
    x=0, y=0, z=0,
    d_clip_hole,
    cardboard_thickness=2.5,
    post_height_above=2,
    post_height_below=1.5,
    tab_height=1.2,
    tab_width=2,
    tab_depth=1.2,
    tab_count=3,
    transition_height=2.0
) {
    translate([x, y, z]) {

        // -------------------------------
        // Section 1: Main Cone
        // -------------------------------
        // Starts immediately above transition
        cone_base_z = 0;
        translate([0,0,cone_base_z + transition_height])
            cylinder(h=h, r1=d_base/2, r2=2, center=false);

        // -------------------------------
        // Section 2: Tapered Transition
        // -------------------------------
        // Smooth slope from shaft to cone base
        transition_r1 = d_clip_hole/2 - 0.2;  // matches post radius
        transition_r2 = d_base/2;             // matches cone base radius
        cylinder(h=transition_height, r1=transition_r1, r2=transition_r2, center=false);

        // -------------------------------
        // Section 3: Post through cardboard
        // -------------------------------
        total_post_height = post_height_above + cardboard_thickness + post_height_below;
        translate([0,0,-total_post_height])
            cylinder(h=total_post_height, r=transition_r1, center=false);

        // -------------------------------
        // Section 4: Tabs (flush with shaft bottom)
        // -------------------------------
        tab_z_start = -total_post_height; // bottom flush
        for (i = [0 : 360/tab_count : 360-360/tab_count]) {
            rotate([0,0,i])
                translate([
                    transition_r1 - 0.5,  // radial placement
                    -tab_width/2,   // center Y
                    tab_z_start     // bottom flush
                ])
                cube([tab_depth, tab_width, tab_height], center=false);
        }
    }
}

// ----- Example Usage -----
clip_cone(
    d_base=40, h=45,
    d_clip_hole=37,
    cardboard_thickness=1,
    post_height_above=1.5,
    post_height_below=1.5,
    tab_height=1.5,
    tab_width=6,
    tab_depth=3,
    tab_count=3,
    transition_height=5
);

// ----- Example Usage -----
clip_cone(
    x=50, y=0, z=0,
    d_base=40, h=45,
    d_clip_hole=37,
    cardboard_thickness=1,
    post_height_above=1.5,
    post_height_below=1.5,
    tab_height=1.5,
    tab_width=6,
    tab_depth=3,
    tab_count=3,
    transition_height=5
);
