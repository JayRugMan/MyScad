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

// Holder measurements
hThickness = cThickness+pThickness;
hRadius = pWidth/2 + 5.02;
hLength = pLength - hRadius*2 + 15.02;

// Monitor cord measurements
mcThickness = pThickness*(201/300);
mcWidth = 17.2;
mcLength = 10.1;

module Charger(xt, yt, zt){
  translate([xt, yt, zt]) 
    color("black") 
    linear_extrude(height = hThickness) {
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
  color("green")
    linear_extrude(hThickness-(pThickness/3))
      translate([hRadius, hRadius, 0])
      hull(){
        circle(hRadius);
        translate([hLength, 0, 0])
          circle(hRadius);
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

module PowerCordSlot(xt, yt, zt){
  translate([xt, yt, zt])
    rotate([0, 90, 0])
    cylinder(h=30, r=5.5, center=false);
}

module MonitorCordSlot(xt, yt, zt){
  translate([xt, yt, zt])
    cube([mcLength, mcWidth, mcThickness], center=false);
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
  PowerCordSlot(-0.01, (pWidth+10)/2, 2.5);
  MonitorCordSlot(pLength+4.99,hRadius-(mcWidth/2),cThickness); 
}



