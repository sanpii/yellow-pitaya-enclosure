WIDTH=500;
HEIGHT=170;
DEPTH=150;

THICKNESS=2;

/* [Hidden] */
DISPLAY_BLOCKS=true;

main();

module main() {
    difference() {
        union() {
            front();
            back();
        }
        rotate([-90, 0, 0])
            translate([-WIDTH / 3 + 20, -DEPTH / 3, HEIGHT])
                linear_extrude(THICKNESS / 2)
                    text("Yellow Pitaya", DEPTH / 3);
    }
}

module front() {
    translate([-WIDTH/3, 0, DEPTH / 2])
        front_left(WIDTH/3, HEIGHT, DEPTH/2);

    translate([0, 0, DEPTH / 2])
        front_middle(WIDTH/3, HEIGHT, DEPTH/2);

    translate([WIDTH/3, 0, DEPTH / 2])
        front_right(WIDTH/3, HEIGHT, DEPTH/2);
}

module back() {
    translate([-WIDTH/3, 0, -DEPTH / 2])
        back_left(WIDTH/3, HEIGHT, DEPTH/2);

    translate([0, 0, -DEPTH / 2])
        back_middle(WIDTH/3, HEIGHT, DEPTH/2);

    translate([WIDTH/3, 0, -DEPTH / 2])
        back_right(WIDTH/3, HEIGHT, DEPTH/2);
}

module part(width, height, depth) {
    cube([width, height, THICKNESS]);

    translate([width, 0, -20])
        rotate([0, -90, 0])
        screw();

    translate([width, height - 20, -20])
        rotate([0, -90, 0])
        screw();

    rotate([0, 90, 0])
        cube([depth, height, THICKNESS]);

    rotate([-90, 0, 0])
        cube([width, depth, THICKNESS]);

    translate([0, height - THICKNESS, 0])
        rotate([-90, 0, 0])
            cube([width, depth, THICKNESS]);
}

module screw() {
    difference() {
        cube([20, 20, 10]);
        translate([10, 10, 0])
            cylinder(10, r=5);
    };
}

module middle_part(width, height, depth) {
    difference() {
        part(width, height, depth);
        rotate([0,90,0])
            translate([0, THICKNESS, 0])
                cube([depth, height - THICKNESS * 2, THICKNESS]);
    };

    translate([10, 0, -20])
        rotate([0, -90, 0])
        screw();

    translate([10, height - 20, -20])
        rotate([0, -90, 0])
        screw();
}

module front_left(width, height, depth) {
    difference() {
        part(width, height, depth);
        translate([THICKNESS + 30, height - 50, 0])
            variable_alim();
        translate([THICKNESS + 35, height - 100, -26 + THICKNESS])
            fixed_alim();
    };

    translate([0, height - 30, -THICKNESS - 30])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 30, -THICKNESS - 30 * 2 - 10])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 80, -THICKNESS - 30])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 80, -THICKNESS - 30 * 2 - 10])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 130, -THICKNESS - 30])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 130, -THICKNESS - 30 * 2 - 10])
        rotate([180, 0, 180])
            sonde();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([THICKNESS + 30, height - 50, -24 + THICKNESS])
                variable_alim();
            translate([THICKNESS + 35, height - 100, -26 + THICKNESS])
                fixed_alim();
        }
    }
}

module variable_alim() {
    dps_screen();
    translate([25, -20, -2])
        banana_pair();
}

module dps_screen() {
    cube([72, 40, 24]);
}

module fixed_alim() {
        banana_pair();
    translate([40, 0, 0])
        banana_pair();
    translate([0, -20, 0])
        banana_pair();
    translate([40, -20, 0])
        banana_pair();
    translate([20, -60, 9])
        power_button();
}

module banana_pair() {
    margin = 19;

    banana_plug();
    translate([margin, 0, 0])
        banana_plug();
}

module banana_plug() {
    cylinder(26, d=13);
}

module front_middle(width, height, depth) {
    screen_size=126;

    difference() {
        union() {
            middle_part(width, height, depth);
            translate([THICKNESS, height - screen_size - THICKNESS * 2, -THICKNESS * 2])
                cube([width - THICKNESS, screen_size + THICKNESS, THICKNESS * 2]);
        };
        translate([-THICKNESS+6, height - screen_size + THICKNESS, -THICKNESS * 2])
            screen_in();
        translate([0, height - screen_size - THICKNESS, -THICKNESS])
            screen_out();
        translate([25, 20, 0])
            bnc();
    };

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([0, height - screen_size - THICKNESS, -THICKNESS])
                screen();
            translate([25, 20, -38 + THICKNESS])
                bnc();
        }
    }
}

module front_right(width, height, depth) {
    screen_size=126;

    difference() {
        rotate([0, 0, 180])
            translate([-width, -height, 0])
                part(width, height, depth);
        translate([-width, height - screen_size + THICKNESS, -THICKNESS * 2])
            screen_in();
        translate([21, 20, 0])
            bnc_plug();
        translate([width - 30, THICKNESS + 3, 0])
            power_button();
    };

    translate([width, height - 30, -THICKNESS])
        sonde();
    translate([width, height - 30, -THICKNESS - 30 - 10])
        sonde();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([width - 30, THICKNESS + 3, -17 + THICKNESS])
                power_button();
            translate([21, 20, -38 + THICKNESS])
                bnc_plug();
        }
    }
}

module screen_in() {
    cube([min(201, WIDTH/2), 115, THICKNESS * 3]);
}

module screen_out() {
    cube([min(210, WIDTH/2), 126, THICKNESS]);
}

module screen() {
    cube([210, 126, THICKNESS]);
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
}

module bnc_plug() {
    cylinder(38, d=21);
}

module power_button() {
    cube([23, 30, 17]);
}

module back_left(width, height, depth) {
    difference() {
        rotate([180, 0, 0])
            translate([0, -height, 0])
                part(width, height, depth);
            translate([27, THICKNESS + 5, THICKNESS + 5])
                power_plug();
            translate([(width - 102) / 2, THICKNESS + 10, 0])
                lm2596();
    };

    translate([0, height - 30, depth - THICKNESS - 30])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 30, depth - THICKNESS - 30 * 2 - 10])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 80, depth - THICKNESS - 30])
        rotate([180, 0, 180])
            sonde();
    translate([0, height - 80, depth - THICKNESS - 30 * 2 - 10])
        rotate([180, 0, 180])
            sonde();


    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([27, THICKNESS + 5, THICKNESS + 5])
                power_plug();
            translate([(width - 93) / 2, height - 73 - THICKNESS, 0])
                dps();
            translate([(width - 102) / 2, THICKNESS + 10, 0])
                lm2596();
        };
    }
}

module power_plug() {
    rotate([0, -90, 0])
        cube([27.5, 50, 27]);
}

module dps() {
    cube([93, 73, 45]);
}

module lm2596() {
    cube([102, 80, 20]);
    translate([0, 23, -THICKNESS - 1])
        cube([88, 15, THICKNESS + 1]);
}

module back_middle(width, height, depth) {
    difference() {
        rotate([180, 0, 0])
            translate([0, -height, 0])
                middle_part(width, height, depth);
        translate([20, THICKNESS, 0])
            redpitaya();
    }


    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([20, THICKNESS, 0])
                redpitaya();
            translate([20, 70, 0])
                raspberry();
        }
    }
}

module redpitaya() {
    cube([110, 60, 25]);
    translate([30, 10, -THICKNESS - 1])
        rotate([0, 0, 45])
            cube([30, 30, THICKNESS + 1]);
}

module raspberry() {
    cube([90, 60, 20]);
}

module back_right(width, height, depth) {
    difference() {
        rotate([0, 180, 0])
            translate([-width, 0, 0])
                part(width, height, depth);
        translate([width - 150 - THICKNESS, THICKNESS, 0])
            alim();
    };

    translate([width, height - 30, depth - THICKNESS])
        sonde();
    translate([width, height - 30, depth - THICKNESS - 30 - 10])
        sonde();

    if (DISPLAY_BLOCKS) {
        color("red")
            translate([width - 150 - THICKNESS, THICKNESS, 0])
                alim();
    }
}

module alim() {
    cube([150, 100, 50]);
    translate([150 - 15 - 60 / 2, 60 / 2 + 5, -THICKNESS])
        cylinder(THICKNESS, d=60);
}

module sonde() {
    rotate([-90, 0, 0]) {
        difference() {
            union() {
                cube([30, 30, 5]);
                difference() {
                    rotate([0, 90, 0])
                        cube([20, 30, 20]);
                    rotate([90, 90, 0])
                        translate([20, 20, -30])
                        cylinder(30, d=40);
                }
            }
            translate([20, 15, -5])
                cylinder(10, d=30);
            rotate([90, 90, 90])
                translate([10, 15, 0])
                    cylinder(10, r=5);
        }
    }
}
