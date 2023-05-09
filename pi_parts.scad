/***********************************************************************************/
/*                                                                                 */
/* Thanks to:                                                                      */
/* https://github.com/RigacciOrg/openscad-rpi-library/blob/master/misc_parts.scad  */
/*                                                                                 */
/***********************************************************************************/

//------------------------------------------------------------------------
// USB male Micro-B connector.
//------------------------------------------------------------------------
module usb_male_micro_b_connector() {
    x1 = 6.85; y1 = 6.70; z1 = 1.80; // Metal part
    x2 = 10.5; y2 = 19;   z2 = 7;    // Plastic part
    r1 = 3.2;  r2 = 2.4; h = 10;     // Plastic cone part
    $fn = 32;
    translate([0, -y1/2, 0]) color("silver") cube([x1, y1, z1], center = true);
    color([82/255, 82/255, 82/255]) {
        translate([0, y2/2, 0]) cube([x2, y2, z2], center = true);
        translate([0, y2 + h/2, 0]) rotate(a=270, v=[1, 0, 0]) cylinder(r1=r1, r2=r2, h=h, center=true);
        translate([0, y2 + h + 5, 0]) rotate(a=90, v=[1, 0, 0]) cylinder(r=3.5/2, h=10, center=true);
    }
}


//------------------------------------------------------------------------
// Holes for the Raspberry Pi B+, 2B, 3B, 3B+ and 4B Models.
//------------------------------------------------------------------------
module raspberrypi_3_model_b_holes() {
    x0 = 3.5; y0 = 3.5; x = 49; y = 58;
    translate([x0, y0]) {
        translate([0, 0]) circle(r=(2.75 / 2), $fn=16);
        translate([x, 0]) circle(r=(2.75 / 2), $fn=16);
        translate([0, y]) circle(r=(2.75 / 2), $fn=16);
        translate([x, y]) circle(r=(2.75 / 2), $fn=16);
    }
}

//------------------------------------------------------------------------
// Matrix of 2.54 mm pins.
//------------------------------------------------------------------------
module pin_headers(cols, rows) {
    w = 2.54; h = 2.54; p = 0.65;
    for(x = [0 : (cols -1)]) {
        for(y = [0 : (rows  - 1)]) {
            translate([w * x, w * y, 0]) {
                union() {
                    color("black") cube([w, w, h]);
                    color("gold")  translate([(w - p) / 2, (w - p) / 2, -3]) cube([p, p, 11.54]);
                }
            }
        }
    }
}


//------------------------------------------------------------------------
// Misc parts
//------------------------------------------------------------------------
module usb_connector(x, y, z) {
    f = 0.6; // Flange
    color("silver") cube([x, y, z]);
    translate([-f, y - f, -f])
        color("silver") cube([x + f * 2, f, z + f * 2]);
}

module audio_video(size_x) {
    color([58/255, 58/255, 58/255]) {
        cube([size_x, 7, 5.6]);
        translate([size_x, 7 / 2, 5.6 / 2]) rotate([0,90,0]) cylinder(d=5.6, h=2.6);
    }
}

module micro_sd_card() {
    color("silver")   translate([0,  0.0, -1.5]) cube([14, 13, 1.5]);
    color("black") translate([2, -3.2, -1.0]) cube([11, 15, 1.0]);
}

module hdmi_connector(x, y, z) {
    color("silver") cube([x, y, z]);
}

module ethernet_connector(x, y, z) {
    color("silver") cube([x, y, z]);
}

module microusb_connector(x, y, z) {
    color("silver") cube([x, y, z]);
}

