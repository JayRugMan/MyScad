$fn = 100;

// Charger measurements
cRadius = 43.75;       //charger circle radius
cThickness = 11.5;     //charger thickness
cCenterXDist = 49.8;   //distence between charger circle centers

// Phone measurements
pThickness = 13.35;    //phone thickness
pLength = 171.75;      //phone length
pWidth = 86.25;        //phone width

// Alignment values for charger translation
cLength = cRadius * 2 + cCenterXDist;
cWidth = cRadius * 2;
xAlign = cRadius + (pLength-cLength) / 2 + 5;
yAlign = cRadius + (pWidth+10-cWidth) / 2;

module Charger(xt, yt, zt){
  translate([xt, yt, zt]) 
    color("black") 
    linear_extrude(height = cThickness+pThickness) {
      hull() {
        circle(cRadius);
        translate([cCenterXDist, 0, 0])
          circle(cRadius);
      }
    }
}

module Phone(xt, yt, zt){
  translate([xt, yt, zt])
    color("blue")
    cube([pLength, pWidth, pThickness]);
}

module Holder(xt, yt, zt){
  r = pWidth/2 + 5.02;
  color("green")
    linear_extrude(pThickness+cThickness-(pThickness/3))
      translate([r, r, 0])
      hull(){
        circle(r);
        translate([pLength - r*2 + 10.02, 0, 0])
          circle(r);
      }
}

module Slopes(xt, yt, zt, rot){
  translate([xt, yt, zt])
    rotate([90, 0, rot])
    linear_extrude(35)
    polygon([[0,0],
             [5.02,5.02],
             [5.02,pThickness + 0.02],
             [0,pThickness + 0.02]]);
}


module SlopeTop(xt, yt, zt){
  color("red")
    translate([xt, yt, zt])
    Slopes(35, 5.01, 0, -90);
}

module SlopeBottom(xt, yt, zt){
  translate([xt, yt, zt])
  Slopes(0, -0.01, 0, 90);
}

module CordSlot(xt, yt, zt){
  translate([xt, yt, zt])
    rotate([0, 90, 0])
    cylinder(h=30, r=5.5, center=false);
}


difference() {
  Holder(0, 0, 0);
  Charger(xAlign, yAlign, -0.01);
  Phone(5, 5, cThickness);
  SlopeTop(xAlign + cCenterXDist/2 - 17.5,
           yAlign + cRadius,
           cThickness - 4);
  SlopeBottom(xAlign + cCenterXDist/2 - 17.5,
              0,
              cThickness - 4);
  CordSlot(-0.01, (pWidth+10)/2, 2.5);
}



