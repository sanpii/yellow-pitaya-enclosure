use <Stencilia-A.ttf>

WIDTH=500;
HEIGHT=170;
DEPTH=150;

THICKNESS=2;

/* [Hidden] */
DISPLAY_BLOCKS=false;

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
        translate([-WIDTH / 3, HEIGHT - 40, -10])
            rotate([0, -90, 0])
                hinge();
        translate([-WIDTH / 3, HEIGHT / 2 - 15, -10])
            rotate([0, -90, 0])
                hinge();
        translate([-WIDTH / 3, 15, -10])
            rotate([0, -90, 0])
                hinge();
    }

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([-WIDTH / 3, HEIGHT - 40, -10])
                rotate([0, -90, 0])
                    hinge();
            translate([-WIDTH / 3, HEIGHT / 2 - 15, -10])
                rotate([0, -90, 0])
                    hinge();
            translate([-WIDTH / 3, 15, -10])
                rotate([0, -90, 0])
                    hinge();
        }
    }
}

module part(width, height, depth) {
    cube([width, height, THICKNESS]);

    translate([width, 12, 0])
        rotate([0, 90, -180])
            screw_support();

    translate([width - 8, height - 12, 0])
        rotate([0, 90, 0])
        screw_support();

    translate([width - 8, 12, -depth])
        rotate([0, -90, -180])
            screw_support();

    translate([width, height - 12, -depth])
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

    translate([8, 12, 0])
        rotate([0, 90, -180])
        screw_support();

    translate([0, height - 12, 0])
        rotate([0, 90, 0])
        screw_support();

    translate([0, 12, -depth])
        rotate([0, -90, -180])
            screw_support();

    translate([8, height - 12, -depth])
        rotate([0, -90, 0])
        screw_support();
}
