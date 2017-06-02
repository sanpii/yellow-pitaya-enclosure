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
    rotate([180, 0, 0])
        front_left(width/2, height, depth/2);

    rotate([180, 0, 180])
        front_right(width/2, height, depth/2);

    back_left(width/2, height, depth/2);

    rotate([0, 0, 180])
        back_right(width/2, height, depth/2);
}

module part(width, height, depth) {
    translate([-width, -height/2, depth]) {
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
}

module front_left(width, height, depth) {
    difference() {
        part(width, height, depth);
    translate([-width+20, 30, depth])
        variable_alim();
    translate([-width+thickness+20, -20, depth])
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
    cube([72, 39, thickness]);
}

module banana_pair() {
    margin = 19;

    banana_plug();
    translate([margin, 0, 0])
        banana_plug();
}

module banana_plug() {
    cylinder(thickness, d=11);
}

module front_right(width, height, depth) {
    difference() {
        union() {
            part(width, height, depth);
            translate([-width+thickness, -height/2+thickness, depth-thickness])
                    cube([width-thickness, 126+thickness*2, thickness]);
        };
        translate([-width+thickness+6, -height/2+thickness*2+3, depth-thickness])
            screen_in();
        translate([-width+thickness, -height/2+thickness*2, depth])
            screen_out();
        translate([-20, height/2-20, depth])
            bnc();
        translate([-width + thickness + 5, height/2-33, depth])
            power_button();
    };

}

module screen_in() {
    cube([min(201, width/2), 115, thickness*2]);
}

module screen_out() {
    cube([min(210, width/2), 126, 3]);
}

module bnc() {
    margin = 35;

        bnc_plug();
    translate([-margin, 0, 0])
        bnc_plug();
    translate([-margin * 2, 0, 0])
        bnc_plug();
    translate([-margin * 3, 0, 0])
        bnc_plug();
    translate([-margin * 4, 0, 0])
        bnc_plug();
}

module bnc_plug() {
    cylinder(thickness, d=21);
}

module power_button() {
    cube([22, 26, thickness]);
}

module back_left(width, height, depth) {
    difference() {
        part(width, height, depth);
        translate([-width + thickness, 0, height/4])
            power_plug();
    };

    translate([-width + 27, 0, height/4])
        color("red")
            power_plug();
}

module power_plug() {
    rotate([0, -90, 0])
        cube([27.5, 50, 27]);
}

module back_right(width, height, depth) {
    difference() {
        part(width, height, depth);
        translate([-150, -30, depth])
            fan();
    };

    translate([-width + thickness, -height/2 + thickness, thickness])
        color("red")
            alim();
}

module alim() {
    cube([150, 100, 50]);
}

module fan() {
    cylinder(thickness, d=60);
}
