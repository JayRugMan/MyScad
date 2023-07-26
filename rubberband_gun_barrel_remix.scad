/********************************************/
/*     Longer barrel with better angle      */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-07-24                 */
/*                                          */
/********************************************/

// Original Design by Gavilan:
// https://www.thingiverse.com/gavilan/designs
// https://www.thingiverse.com/thing:217067

$fn = 500;

// Dimensions
diffx_buffer = 0.1;  // difference extrusion buffer
translation_offset = diffx_buffer / 2; 
z_height = 18.2;                              // z - from bed
cutout_depth = z_height + diffx_buffer;       // just longer than bar height for difference

bar_length = 180;                             // x - as expected
bar_width = 16;                               // y - from bed
bar_tip_rad = 23.45 / 2;                      // x
bar_tip_offset = bar_tip_rad-2.5;             // x

scrw_hole_diam = 2.5;                         // x - square side
scrw_hole_distance = 29.4;                    // x

a0 = [[-2,0],[0,7.8],[135,7.8],[136,0]];      // main
b0 = [0, 1, 2, 3];
a1 = [                                        // Letter B
      [-2,0],[0,7.8],[15,7.8],                // points A, B, C
      [14.5,7],[12.5,7],[12,6.2],             // points D, E, F
      [16.5,6.2],[17,7],[15,7],           // Points G, H, I
      [15.5,7.8],[22,7.8],[21,4.2],             // Points J, K, L
      [17,4.2],[16.8,3.7],[20.9,3.7],             // Points M, N, O
      [20,0],[12.5,0],[13.1,1.2],                       // Points P, Q, R
      [15.1,1.2],[15.6,2],[11.1,2],                             // Points S, T, U
      [10.6,1.2],[12.6,1.2],[12,0]                            // Points V, W, X
];
b1 = [
  0, 1, 2, 3,
  4, 5, 6,
  7, 8, 9,
  10, 11, 12,
  13, 14, 15,
  16, 17, 18,
  19, 20, 21,
  22, 23//, 24,
  //25, 26, 27
];
cutout_points = concat (a0);
cutout_paths = [b0];

sight_height = 21;                            // y - before rotation
sight_width = z_height;                       // x - before rotation
sight_cutout_rad = 25.5/2;                    // x
sight_cutout_offset = sight_cutout_rad-3.6;   // y - before rotation
sight_thickness = 4.2;                        // z - before rotation

// Modules
module scrw_hole(tx=0, ty=0, tz=0) {
  translate([tx, ty, tz - translation_offset]) {
    cube([scrw_hole_diam, scrw_hole_diam, cutout_depth]);
  }
}

module scrw_hole_pair(ptx=0, pty=0, ptz=0) {
      scrw_hole(ptx, pty, ptz);
      scrw_hole(ptx+scrw_hole_distance, pty, ptz);
}

module long_cutaway(tx=0, ty=0, tz=0) {
  translate([tx, ty, tz - translation_offset]) {
    linear_extrude(height=cutout_depth) {
      polygon(cutout_points, cutout_paths);
    }
  }
}

module elps_cutaway(tx=0, ty=0, tz=0) {
  translate([tx, ty, tz - translation_offset]) {
    scale([4.5, 1, 1]) {
      cylinder(h=cutout_depth, r=7.8);
    }
  }
}

module the_sight(rx=0, ry=0, rz=0, tx=0, ty=0, tz=0) {
  translate([tx, ty, tz]) {
    rotate([rx, ry, rz]) {
      linear_extrude(height=sight_thickness) {
        difference() {
          square([sight_width ,sight_height]);
          translate([sight_width/2, sight_height+sight_cutout_offset, 0]) {
            circle(sight_cutout_rad);
          }
        }
      }
    }
  }
}

module main_barrel() {
  difference() {
    union() {
      cube([bar_length,bar_width,z_height]);
      the_sight(rx=0, ry=90, rz=0, tx=7.9, ty=0, tz=sight_width);
    }
    translate([bar_length+bar_tip_offset, bar_width/2, 0]) {
      cylinder(h=cutout_depth*2, r=bar_tip_rad, center=true);
    }
  }
}

// module calls
difference() {
  main_barrel();
  scrw_hole_pair(ptx=3, pty=bar_width-(3.2+scrw_hole_diam), ptz=0);
  long_cutaway(39, 2, 0);
  elps_cutaway(0, 0, 0);
}

*long_cutaway(39, 2, 0);