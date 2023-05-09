$fn = 500;

// Charger measurements
cDiameter = 101;
cRadius = cDiameter / 2;    //charger circle radius
cThickness = 7.3;           //charger thickness

// Phone measurements
pThickness = 13.35;    //phone thickness
pLength = 171.75;      //phone length
pWidth = 86.25;        //phone width

Boarder_Width = pWidth>=cDiameter ? (pWidth-cDiameter)/2 : (cDiameter-pWidth)/2;

// Holder measurements
hThickness = cThickness + (pThickness* 2/3);
hRadius = pWidth>=cDiameter ? pWidth/2 : cDiameter/2 ;
hCenterDistance = pLength - hRadius*2 + Boarder_Width*2;
hLength = pLength + Boarder_Width*2;
hWidth = pWidth>=cDiameter ? (pWidth + Boarder_Width*2) : cDiameter ;

// Power cord measurements
pcThickness = cThickness;
pcRadius = pcThickness/2;
pcWidth = 10.8;

// Monitor cord measurements
mcThickness = pThickness*(201/300);
mcWidth = 17.2;
mcLength = Boarder_Width;

// Initials
scale_factor = 0.1;
surface_file = "initials_5.png";
ix=((hLength/2-cRadius+Boarder_Width)/2);
iy=hWidth/2;
iz=cThickness-1.8;

module initials(xt=0, yt=0, zt=0, xr=0, yr=0, zr=0, xm=0, ym=0, zm=0) {
  translate([xt,yt,zt]) 
  scale([scale_factor,scale_factor,scale_factor+0.24]) 
  rotate([xr,yr,zr])
  mirror([xm,ym,zm])
  surface(file = surface_file, center = true, invert = true, convexity = 5);
}

module Charger(xt, yt, zt){
  translate([xt, yt, zt]) 
    color("black") 
    linear_extrude(height = cThickness) {
      circle(cRadius);
    }
}

module Phone(xt, yt, zt){
  translate([xt, yt, zt])
    color("blue")
    cube([pLength, pWidth, pThickness]);
}

module Holder(xt, yt, zt){
  color("green")
    linear_extrude(hThickness)
      translate([hRadius, hRadius, 0])
      hull(){
        circle(hRadius);
        translate([hCenterDistance, 0, 0])
          circle(hRadius);
      }
}

module PowerCordSlot(xt, yt, zt){
  translate([xt, yt, zt])
    cube([pcWidth, mcLength, pcThickness], center=true);
}

module MonitorCordSlot(xt, yt, zt){
  translate([xt, yt, zt])
    cube([mcLength, mcWidth, mcThickness], center=false);
}


difference() {
  Holder(0, 0, 0);
  Charger(hLength/2, hWidth/2, 0);
  Phone(Boarder_Width, Boarder_Width, cThickness);
  initials(xt=ix, yt=iy, zt=iz, xr=0, yr=180, zr=0, xm=1, ym=0, zm=0);
  PowerCordSlot(hLength/2, 0, pcThickness/2);
  PowerCordSlot(hLength/2, hWidth, pcThickness/2);
  MonitorCordSlot(pLength+Boarder_Width,hRadius-(mcWidth/2),cThickness); 
}

*translate([hLength/2,cRadius,0]) linear_extrude(15) circle(1);
*initials(xt=ix, yt=iy, zt=iz, xr=0, yr=180, zr=0, xm=1, ym=0, zm=0);

