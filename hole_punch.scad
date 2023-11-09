/********************************************/
/*     import stl and punch a hole in it    */
/*                                          */
/*        Created by Jason Hardman          */
/*               2023-10-21                 */
/*                                          */
/********************************************/


/*  Definitions  */
$fn = 500;


/* Modlule Definitions */

module the_cyl(tx=0, ty=0, tz=0, ch=5, cir=5 ) {
    // This is a ring

    translate([tx, ty, tz]) {
        cylinder(h=ch, r=(cir/2), center=true);
    }
}


module final_object(
    the_stl="",               // STL file to import
    o_cyr_h = 0,              // Outter Cylinder height
    i_cir = 0,                // Inner hole circumfrence
    tran_x = 0,               // Inner/Outter hole x translation
    tran_y = 0,               // Inner/Outter hole y translation
    mx = 0,                   // STL file x translation
    my = 0,                   // STL file y translation
    scl = 1                   // STL scale ( can be number or list of axese [x, y, z] )
    ) {
    // stl with Hole

    i_cyr_h = o_cyr_h+1;      // inner cyl height
    o_cir = i_cir*1.6;        // outer circumfrence
    tran_z = o_cyr_h/2;       // lift half cylinder height

    difference() {
        union() {
            translate([mx, my, 0]) {
                scale(scl) import(the_stl);
            }
            the_cyl(tx=tran_x, ty=tran_y, tz=tran_z, ch=o_cyr_h, cir=o_cir);
        }
        the_cyl(tx=tran_x, ty=tran_y, tz=tran_z-0.2, ch=i_cyr_h, cir=i_cir);
    }

}


/* Module Calls */

translate([-50,0, 0]) {
    final_object(
        the_stl="Republic.stl",
        o_cyr_h = 3, 
        i_cir = 3, 
        tran_x = 0, 
        tran_y = 20,
        mx = 0,
        my = 0,
        scl = 0.4
    );
}


translate([50,0, 0]) {
    final_object(
        the_stl="Mandalorian_Circle_Background.stl",
        o_cyr_h = 3.3, 
        i_cir = 3, 
        tran_x = 0, 
        tran_y = 17.5,
        mx = -60,
        my = -60,
        scl = [1,1,1.5]
    );
}