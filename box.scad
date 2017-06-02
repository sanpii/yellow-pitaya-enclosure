// @TODO Fixation, charnière ?
// @TODO Fixation alim, lm, raspberry, redpitaya, dsp et pcb lm
// @TODO Support sonde droite (x2) et gauches (x5)
// @TODO Trous sd raspberry

width=450;
height=170;
depth=150;

thickness=3;

main();

module main() {
    translate([-width/2, 0, depth / 2])
        front_left(width/2, height, depth/2);

    translate([0, 0, depth / 2])
        front_right(width/2, height, depth/2);

    translate([-width/2, 0, -depth / 2])
        back_left(width/2, height, depth/2);

    translate([0, 0, -depth / 2])
        back_right(width/2, height, depth/2);
}

module part(width, height, depth) {
    cube([width, height, thickness]);

    rotate([0, 90, 0])
        cube([depth, height, thickness]);

    rotate([-90, 0, 0])
        cube([width, depth, thickness]);

    rotate([-90, 0, 0])
        cube([width, depth, thickness]);

    translate([0, height-thickness, 0])
        rotate([-90, 0, 0])
            cube([width, depth, thickness]);
}

module front_left(width, height, depth) {
    difference() {
        part(width, height, depth);
    translate([thickness + 20, height - 50, 0])
        variable_alim();
    translate([thickness + 20, height - 100, 0])
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
    cube([72, 40, thickness]);
}

module banana_pair() {
    margin = 19;

    banana_plug();
    translate([margin, 0, 0])
        banana_plug();
}

module banana_plug() {
    cylinder(thickness, d=13);
}

module front_right(width, height, depth) {
    screen_size=126;

    difference() {
        union() {
            rotate([0, 0, 180])
                translate([-width, -height, 0])
                    part(width, height, depth);
            translate([thickness, height - screen_size - thickness * 2, -thickness * 2])
                cube([width - thickness, screen_size + thickness, thickness * 2]);
        };
        translate([-thickness+6, height - screen_size + thickness, -thickness * 2])
            screen_in();
        translate([0, height - screen_size - thickness, -thickness])
            screen_out();
        translate([20, 20, 0])
            bnc();
        translate([width - 40, thickness + 3, 0])
            power_button();
    };
}

module screen_in() {
    cube([min(201, width/2), 115, thickness * 3]);
}

module screen_out() {
    cube([min(210, width/2), 126, thickness]);
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
    cylinder(thickness, d=21);
}

module power_button() {
    cube([23, 30, thickness]);
}

module back_left(width, height, depth) {
    difference() {
        rotate([180, 0, 0])
            translate([0, -height, 0])
                part(width, height, depth);
            translate([27, thickness + 5, thickness + 5])
            power_plug();
    };

    color("red")
        translate([27, thickness + 5, thickness + 5])
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
        translate([width - 60, 60, -thickness])
            fan();
    };

    color("red")
        translate([width - 150 - thickness, thickness, thickness])
            alim();
}

module alim() {
    cube([150, 100, 50]);
}

module fan() {
    cylinder(thickness, d=60);
}
