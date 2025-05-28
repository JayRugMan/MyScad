/********************************************/
/*                Initials                  */
/*                                          */
/*        Created by Jason Hardman          */
/*               2025-05-27                 */
/*                                          */
/********************************************/

//$fn = 100;

// Functions

function array_reverse(arr) = [ for (i = [len(arr)-1 : -1 : 0]) arr[i] ];

// Modules and Functions

module the_h(e=1.75) {
    points = [
        [-4.55,4.31],   // 0
        [-3.65,4.31],   // 1
        [-3.65,2.13],   // 2
        [-2.27,2.13],   // 3
        [-2.27,4.31],   // 4
        [-1.45,4.31],   // 5
        [-1.45,2.13],   // 6
        [-0.27,2.13],   // 7
        [-0.27,1.31],   // 8
        [-1.45,1.31],   // 9
        [-1.45,-2.15],  // 10
        [-2.27,-2.15],  // 11
        [-2.27,1.31],   // 12
        [-3.65,1.31],   // 13
        [-3.65,-4.31],  // 14
        [-4.55,-4.31],  // 15
        [-4.55,1.31],   // 16
        [-6.21,1.31],   // 17
        [-6.21,2.13],   // 18
        [-4.55,2.13]    // 19
    ];
    path = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]];
    linear_extrude(e)
    polygon(points,path,10);
}

module the_r(e=2.25) {
    points = [
        [1.57,4.31],    // 0
        [2.35,4.31],    // 1
        [2.35,-2.15],   // 2
        [1.57,-2.15],   // 3
        [1.57,-0.17],   // 4
        [-2.73,-4.33],  // 5
        [-3.31,-3.64],  // 6
        [1.57,0.99]  // 7
    ];
    path = [[0,1,2,3,4,5,6,7]];
    linear_extrude(e)
    union() {
        polygon(points,path,10);
        translate([0.13,1.87,0])
        difference() {
            circle(2.01);
            circle(1.1);
        }
    }
}

module j_hook(r_outer=30, r_inner=15, angle=180, steps=100) {
    // Angles from 180 to 360 degrees, steps+1 points
    angles = [ for (i = [0 : steps]) 180 + i * angle / steps ];

    outer_points = [ for (a = angles) [cos(a) * r_outer, sin(a) * r_outer] ];
    inner_points = [ for (a = angles) [cos(a) * r_inner, sin(a) * r_inner] ];

    points = concat(outer_points, inner_points);

    outer_path = [ for (i = [0 : steps]) i ];
    inner_path = array_reverse([ for (i = [steps + 1 : 2 * (steps + 1) - 1]) i ]);

    polygon(points,[outer_path, inner_path],10);
}

module the_j () {
    points = [
        [2.15,4.31],
        [2.15,-2.12],
        [2.97,-2.12],
        [2.97,4.31],
    ];
    path = [[0,1,2,3]];
    linear_extrude(3) 
    union() {
        polygon(points,path,10);
        translate([4.18,-2.12,0]) j_hook(r_outer=2.03, r_inner=1.21);
    }
}

module initials(tx=0, ty=0, tz=0, rx=0, ry=0, rz=0) {
    translate([tx,ty,tz])
    rotate([rx,ry,rz])
    difference() {
        the_j();
        the_r(3.1);
    }
    translate([tx,ty,tz])
    rotate([rx,ry,rz])
    difference() {
        the_r();
        the_h(2.3);
    }
    translate([tx,ty,tz])
    rotate([rx,ry,rz])
    the_h();
}

// Module Calls

*initials();


