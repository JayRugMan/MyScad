/********************************************/
/*     Shop Pencil Sharpening Lathe Bit     */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-10-21                 */
/*                                          */
/********************************************/


/*  Definitions  */
$fn = 500;

inch = 25.4;
mil = 1;

module the_cube(tx=0, ty=0, tz=0, dimention=1) {
    // One inch by one inch by one inch
    translate([tx, ty, tz]) {
        cube(dimention);
    }
}

the_cube(dimention = 15.33);