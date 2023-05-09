$fn=500;

the_radius = 38.8/2;
for (i = [0:0.1:2], j = [1:-0.02:0]) {
  translate([0,0,(i)])
    circle((the_radius + (i * j)));
}

circle(the_radius);