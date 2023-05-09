$fn = 200;

/***********************************************************************************/
/*                                                                                 */
/* Thanks to:                                                                      */
/* https://github.com/RigacciOrg/openscad-rpi-library/blob/master/misc_boards.scad */
/*                                                                                 */
/***********************************************************************************/

include <pi_parts.scad>;

//------------------------------------------------------------------------
// Raspberry Pi 3 Model B v.1.2.
//------------------------------------------------------------------------
module board_raspberrypi_3_model_b(the_x=0, the_y=0, the_z=0) {
    x  = 56;     y = 85;    z = 1.60;  // Measured PCB size
    ex = 15.9; ey = 21.5; ez = 13.5;   // Ethernet measure
    ux = 13.1; uy = 17.1; uz = 15.5;   // Measured USB connector size
    hx = 11.40; hy = 15.1; hz = 6.15;  // Measured HDMI connector size
    mx =  5.60; my =  7.6; mz = 2.40;  // Measured micro USB power connector size
    // The origin is the lower face of PCB.
    translate([the_x, the_y, z + the_z]) {
        translate([1.0, 7.1, 0])                    pin_headers(2, 20);
        translate([x - ex - 2.3, y - ey + 2.1, 0])  ethernet_connector(ex, ey, ez);
        translate([ 2.5, 85 - uy + 2.1, 0])         usb_connector(ux, uy, uz);
        translate([20.5, 85 - uy + 2.1, 0])         usb_connector(ux, uy, uz);
        translate([x - hx + 1.8, 25, 0])            hdmi_connector(hx, hy, hz);
        translate([x - 12.8, 50, 0])                audio_video(12.8);
        translate([20.5, 0.8, -z])                  micro_sd_card();
        translate([x - mx + 1, 7, 0])               microusb_connector(mx, my, mz);
        translate([x + 2.2, 10.55, 1.2])            rotate(a=270, v=[0, 0, 1]) usb_male_micro_b_connector();
        translate([0, 0, -z]) {
            color("green") linear_extrude(height=z)
                difference() {
                    hull() {
                        translate([  3,   3]) circle(r=3);
                        translate([x-3,   3]) circle(r=3);
                        translate([x-3, y-3]) circle(r=3);
                        translate([  3, y-3]) circle(r=3);
                    }
                    raspberrypi_3_model_b_holes();
                }
        }
    }
}