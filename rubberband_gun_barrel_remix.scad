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
z_height = 18.2;                                    // z - from bed
cutout_depth = z_height + diffx_buffer;             // just longer than bar height for difference

bar_length = 180;                                   // x - as expected
bar_width = 16;                                     // y - from bed
bar_tip_rad = 23.45 / 2;                            // x
bar_tip_offset = bar_tip_rad-2.5;                   // x

scrw_hole_diam = 2.5;                               // x - square side
scrw_hole_distance = 29.4;                          // x

/// Name Cutouts 1
//// Prefix - 1
prefix1_points = [[-2,0],[0,7.8],[17,7.8],[15,0]];  // points 0, 1, 2, 3 - main
//JH prefix1_points = [[-2,0],[0,7.8],[135,7.8],[137,0]];      // points 0, 1, 2, 3 - main
prefix1_paths = [[0,1,2,3]];
//// 'B' - 1
the_B1_points = [
  [17,0],[19,7.8],[22.5,7.8],                       // points 0, 1, 2
  [22.17,6.5],[21.17,6.5],[20.965,5.7],             // points 3, 4, 5
  [23.365,5.7],[23.57,6.5],[22.567,6.5],            // Points 6, 7, 8
  [22.9,7.8],[26,7.8],[27,6.8],                     // Points 9, 10, 11
  [26.282,4],[24.282,4],[24.077,3.2],               // Points 12, 13, 14
  [26.077,3.2],[25.513,1],[24,0],                   // Points 15, 16, 17
  [20.9,0],[21.233,1.3],[22.237,1.3],               // Points 18, 19, 20
  [22.442,2.1],[20.042,2.1],[19.837,1.3],           // Points 21, 22, 23
  [20.83,1.3],[20.5,0]                              // Points 24, 25
];
the_B1_paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]];
//// 'E' - 1
the_E1_points = [
  [27,0],[29,7.8],[37,7.8],                         // Points 0, 1, 2
  [36.487,5.8],[33.82,5.8],[33.615,5],              // Points 3, 4, 5
  [36.282,5],[35.718,2.8],[33.051,2.8],             // Points 6, 7, 8
  [32.846,2],[35.513,2],[35,0]                      // Points 9, 11, 12
];
the_E1_paths = [[0,1,2,3,4,5,6,7,8,9,10,11]];
//// 'N' - 1
the_N1_points = [
  [37,0],[39,7.8],[43.8,7.8],                       // Points 0, 1, 2
  [42.313,2],[43.513,2],[45,7.8],                   // Points 3, 4, 5
  [47,7.8],[45,0],[40.2,0],                         // Points 6, 7, 8
  [41.482,5],[40.282,5],[39,0]                      // Points 9, 11, 12
];
the_N1_paths = [[0,1,2,3,4,5,6,7,8,9,10,11]];
//// suffix - 1
suffix1_points = [[47,0],[49,7.8],[66,7.8],[66,0]]; // points 0, 1, 2, 3 - suffix
suffix1_paths = [[0,1,2,3]];

/// Name Cutout 2
prefix2_points = [[69,0],[69,7.8],[86,7.8],[88,0]]; // points 0, 1, 2, 3 - main
prefix2_paths = [[0,1,2,3]];
//// 'N' - 2
the_N2_points = [
  [90,0],[88,7.8],[90,7.8],                         // Points 0, 1, 2
  [91.487,2],[92.687,2],[91.2,7.8],                 // Points 3, 4, 5
  [96,7.8],[98,0],[96,0],                           // Points 6, 7, 8
  [94.718,5],[93.518,5],[94.8,0]                    // Points 9, 11, 12
];
the_N2_paths = [[0,1,2,3,4,5,6,7,8,9,10,11]];
//// 'E' 2
the_E2_points = [
  [100,0],[99.487,2],[102.19,2],                         // Points 0, 1, 2
  [101.985,2.8],[99.282,2.8],[98.718,5],              // Points 3, 4, 5
  [101.421,5],[101.216,5.8],[98.513,5.8],             // Points 6, 7, 8
  [98,7.8],[106,7.8],[108,0]                      // Points 9, 11, 12
];
the_E2_paths = [[0,1,2,3,4,5,6,7,8,9,10,11]];
//// 'B' - 2
the_B2_points = [
  [111,0],[110,1],[109.436,3.2],                       // points 0, 1, 2
  [111.436,3.2],[111.231,4],[109.231,4],             // points 3, 4, 5
  [108.513,6.8],[109,7.8],[112.1,7.8],            // Points 6, 7, 8
  [112.433,6.5],[111.433,6.5],[111.638,5.7],                     // Points 9, 10, 11
  [114.038,5.7],[113.833,6.5],[112.833,6.5],               // Points 12, 13, 14
  [112.5,7.8],[116,7.8],[118,0],                   // Points 15, 16, 17
  [114.5,0],[114.167,1.3],[115.167,1.3],               // Points 18, 19, 20
  [114.962,2.1],[112.562,2.1],[112.767,1.3],           // Points 21, 22, 23
  [113.767,1.3],[114.1,0]                              // Points 24, 25
];
the_B2_paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]];
//// suffix - 2
suffix2_points = [[120,0],[118,7.8],[135,7.8],[137,0]]; // points 0, 1, 2, 3 - suffix
suffix2_paths = [[0,1,2,3]];

/// Sight
sight_height = 21;                                  // y - before rotation
sight_width = z_height;                             // x - before rotation
sight_cutout_rad = 25.5/2;                          // x
sight_cutout_offset = sight_cutout_rad-3.6;         // y - before rotation
sight_thickness = 4.2;                              // z - before rotation


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
      polygon(prefix1_points, prefix1_paths);
      polygon(the_B1_points, the_B1_paths);
      polygon(the_E1_points, the_E1_paths);
      polygon(the_N1_points, the_N1_paths);
      polygon(suffix1_points, suffix1_paths);
    }
    linear_extrude(height=cutout_depth) {
      polygon(prefix2_points, prefix2_paths);
      polygon(the_N2_points, the_N2_paths);
      polygon(the_E2_points, the_E2_paths);
      polygon(the_B2_points, the_B2_paths);
      polygon(suffix2_points, suffix2_paths);
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