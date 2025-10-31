// =============================
// Clip-On Cone (Tabs Flush)
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 200; // smooth surface quality

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
    tab_count=3
) {
    translate([x, y, z]) {

        // --- 1. Main cone (sits above cardboard) ---
        cylinder(h=h, r1=d_base/2, r2=2, center=false);

        // --- 2. Post through cardboard ---
        total_post_height = post_height_above + cardboard_thickness + post_height_below;
        translate([0,0,-total_post_height])
            cylinder(h=total_post_height, r=d_clip_hole/2 - 0.2, center=false);

        // --- 3. Tabs under cardboard, flush with shaft bottom ---
        // Shaft bottom is at z = -(total_post_height)
        // Tabs sit directly under the cardboard, bottom flush with shaft bottom
        tab_z_start = -total_post_height; // bottom flush
        for (i = [0 : 360/tab_count : 360-360/tab_count]) {
            rotate([0,0,i])
                translate([
                    (d_clip_hole/2 - 0.2),  // radial placement
                    -tab_width/2,           // center Y
                    tab_z_start             // bottom flush with shaft
                ])
                cube([tab_depth, tab_width, tab_height], center=false);
        }
    }
}

// ----- Example Usage -----
clip_cone(
    d_base=82, h=90,
    d_clip_hole=79,
    cardboard_thickness=2.5,
    post_height_above=1.5,
    tab_height=2,
    tab_width=4,
    tab_depth=3,
    tab_count=4
);
