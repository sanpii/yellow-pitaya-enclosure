// @TODO Fixation, charnière ?
// @TODO Fixation alim, lm, raspberry, redpitaya, dsp et pcb lm
// @TODO Support sonde droite (x2) et gauches (x5)
// @TODO Trous sd raspberry

WIDTH=450;
HEIGHT=170;
DEPTH=150;

THICKNESS=3;

main();

module main() {
    translate([-WIDTH/2, 0, DEPTH / 2])
        front_left(WIDTH/2, HEIGHT, DEPTH/2);

    translate([0, 0, DEPTH / 2])
        front_right(WIDTH/2, HEIGHT, DEPTH/2);

    translate([-WIDTH/2, 0, -DEPTH / 2])
        back_left(WIDTH/2, HEIGHT, DEPTH/2);

    translate([0, 0, -DEPTH / 2])
        back_right(WIDTH/2, HEIGHT, DEPTH/2);
}

module part(width, height, depth) {
    cube([width, height, THICKNESS]);

    rotate([0, 90, 0])
        cube([depth, height, THICKNESS]);

    rotate([-90, 0, 0])
        cube([width, depth, THICKNESS]);

    rotate([-90, 0, 0])
        cube([width, depth, THICKNESS]);

    translate([0, height-THICKNESS, 0])
        rotate([-90, 0, 0])
            cube([width, depth, THICKNESS]);
}

module front_left(width, height, depth) {
    difference() {
        part(width, height, depth);
    translate([THICKNESS + 20, height - 50, 0])
        variable_alim();
    translate([THICKNESS + 20, height - 100, 0])
        fixed_alim();
    };
}

module variable_alim() {
        dps();
    translate([25, -20, 0])
        banana_pair();
}

module fixed_alim() {
        banana_pair();
    translate([40, 0, 0])
        banana_pair();
    translate([0, -20, 0])
        banana_pair();
    translate([40, -20, 0])
        banana_pair();
    translate([20, -60, 0])
        power_button();
}

module dps() {
    cube([72, 40, THICKNESS]);
}

module banana_pair() {
    margin = 19;

    banana_plug();
    translate([margin, 0, 0])
        banana_plug();
}

module banana_plug() {
    cylinder(THICKNESS, d=13);
}

module front_right(width, height, depth) {
    screen_size=126;

    difference() {
        union() {
            rotate([0, 0, 180])
                translate([-width, -height, 0])
                    part(width, height, depth);
            translate([THICKNESS, height - screen_size - THICKNESS * 2, -THICKNESS * 2])
                cube([width - THICKNESS, screen_size + THICKNESS, THICKNESS * 2]);
        };
        translate([-THICKNESS+6, height - screen_size + THICKNESS, -THICKNESS * 2])
            screen_in();
        translate([0, height - screen_size - THICKNESS, -THICKNESS])
            screen_out();
        translate([20, 20, 0])
            bnc();
        translate([width - 40, THICKNESS + 3, 0])
            power_button();
    };
}

module screen_in() {
    cube([min(201, WIDTH/2), 115, THICKNESS * 3]);
}

module screen_out() {
    cube([min(210, WIDTH/2), 126, THICKNESS]);
}

module bnc() {
    margin = 35;

        bnc_plug();
    translate([margin, 0, 0])
        bnc_plug();
    translate([margin * 2, 0, 0])
        bnc_plug();
    translate([margin * 3, 0, 0])
        bnc_plug();
    translate([margin * 4, 0, 0])
        bnc_plug();
}

module bnc_plug() {
    cylinder(THICKNESS, d=21);
}

module power_button() {
    cube([23, 30, THICKNESS]);
}

module back_left(width, height, depth) {
    difference() {
        rotate([180, 0, 0])
            translate([0, -height, 0])
                part(width, height, depth);
            translate([27, THICKNESS + 5, THICKNESS + 5])
            power_plug();
    };

    color("red")
        translate([27, THICKNESS + 5, THICKNESS + 5])
            power_plug();
}

module power_plug() {
    rotate([0, -90, 0])
        cube([27.5, 50, 27]);
}

module back_right(width, height, depth) {
    difference() {
        rotate([0, 180, 0])
            translate([-width, 0, 0])
                part(width, height, depth);
        translate([width - 60, 60, -THICKNESS])
            fan();
    };

    color("red")
        translate([width - 150 - THICKNESS, THICKNESS, THICKNESS])
            alim();
}

module alim() {
    cube([150, 100, 50]);
}

module fan() {
    cylinder(THICKNESS, d=60);
}
