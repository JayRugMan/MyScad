// =============================
// Spacer for tiles in path
// Optimized for transparent PLA Printing
// OpenSCAD 2021.01 Compatible
// =============================

$fn = 300; // smooth surface quality

//// dimensions ////
// print settings //
layer_h = 0.2; // layer height
layers = 15; // number of layers
overhang_thickness = layer_h * layers; 
// Path //
path_length = 217.5; // inches
// width = Don't remember
// Tiles //
tile_widthHeight = 23.5; // inches
tile_thickness = 0.763; // inches
tile_count = 8; // number of tiles in path
t_thick_mm = tile_thickness * 25.4; // convert to mm
tile_spacing = (path_length - (tile_count * tile_widthHeight)) / (tile_count + 1); // inches
tile_spacing_mm = tile_spacing * 25.4; // convert to mm

// spacer //
spacer_width = 45; // width of spacer
overhang = 30; // mm of overhang

// modules

module spacer() {
    // base, which will be the top that goes over each tile being spaced
    cube([tile_spacing_mm + (overhang * 2), spacer_width, overhang_thickness]);
    // actual spacer between tiles
    translate([overhang,0,overhang_thickness]) cube([tile_spacing_mm, spacer_width, t_thick_mm - 5]);
}

// display

spacer();
echo("tile spacing (inch): ", tile_spacing ); 
echo("tile spacing (mm): ", tile_spacing_mm);