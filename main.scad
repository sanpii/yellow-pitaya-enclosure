use <Stencilia-A.ttf>

WIDTH=500;
HEIGHT=170;
DEPTH=150;

THICKNESS=2;

/* [Hidden] */
DISPLAY_BLOCKS=true;

include <back.scad>;
include <components.scad>;
include <connection.scad>;
include <front.scad>;
include <supports.scad>;

main();

module main() {
    difference() {
        union() {
            front();
            back();
        }
        rotate([-90, 0, 0])
            translate([-WIDTH / 3 + 30, 20, HEIGHT - 1])
                linear_extrude(THICKNESS)
                    text("Yellow Pitaya", DEPTH / 3, "Stencilia\\-A:style=Regular");
    }
}

module part(width, height, depth) {
    cube([width, height, THICKNESS]);

    translate([width - 10, 16, -16])
        rotate([0, -90, -180])
            screw_support();

    translate([width, height - 16, -16])
        rotate([0, -90, 0])
        screw_support();

    translate([width - 10, 16, -depth + 4])
        rotate([0, -90, -180])
            screw_support();

    translate([width, height - 16, -depth + 4])
        rotate([0, -90, 0])
        screw_support();

    difference() {
        rotate([0, 90, 0])
            cube([depth, height, THICKNESS]);

        for (y=[0:height / 4:height]) {
            if (y != 0 && y != height) {
                translate([0, y, -15])
                    rotate([0, -90, 0])
                    rotate([0, 0, 90])
                    screw();

                translate([0, y, -15 - 36])
                    rotate([0, -90, 0])
                    rotate([0, 0, 90])
                    screw();
            }
        }
    }

    rotate([-90, 0, 0])
        cube([width, depth, THICKNESS]);

    translate([0, height - THICKNESS, 0])
        rotate([-90, 0, 0])
            cube([width, depth, THICKNESS]);
}

module middle_part(width, height, depth) {
    difference() {
        part(width, height, depth);
        rotate([0,90,0])
            translate([0, THICKNESS, 0])
                cube([depth, height - THICKNESS * 2, THICKNESS]);
    };

    translate([0, 16, -16])
        rotate([0, -90, -180])
        screw_support();

    translate([10, height - 16, -16])
        rotate([0, -90, 0])
        screw_support();

    translate([0, 16, -depth + 4])
        rotate([0, -90, -180])
            screw_support();

    translate([10, height - 16, -depth + 4])
        rotate([0, -90, 0])
        screw_support();
}
