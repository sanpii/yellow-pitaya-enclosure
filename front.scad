module front() {
    translate([-WIDTH/3, 0, DEPTH / 2])
        front_left(WIDTH/3, HEIGHT, DEPTH/2);

    translate([0, 0, DEPTH / 2])
        front_middle(WIDTH/3, HEIGHT, DEPTH/2);

    translate([0, 0, DEPTH / 2])
        screen_fix(WIDTH/3, HEIGHT, DEPTH/2);

    translate([WIDTH/3, 0, DEPTH / 2])
        front_right(WIDTH/3, HEIGHT, DEPTH/2);
}

module front_left(width, height, depth) {
    difference() {
        part(width, height, depth);
        translate([width / 2 - 37.5, height - 60, -24 + THICKNESS])
            variable_alim();
        translate([width / 2 - 50, height - 120, -26 + THICKNESS])
            fixed_alim();
    };

    translate([0, height - 30, -27])
        rotate([180, 0, 180])
            support_banana();
    translate([0, height - 30, -63])
        rotate([180, 0, 180])
            support_banana();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([width / 2 - 37.5, height - 60, -24 + THICKNESS])
                variable_alim();
            translate([width / 2 - 50, height - 120, -26 + THICKNESS])
                fixed_alim();
        }
    }
}

module front_middle(width, height, depth) {
    difference() {
        union() {
            middle_part(width, height, depth);
            translate([THICKNESS, 0, -THICKNESS])
                cube([width - THICKNESS, height, THICKNESS * 2]);
        };
        translate([-THICKNESS + 6, height - SCREEN_HEIGHT - 6, 0])
            screen_in();
        translate([0, height - SCREEN_HEIGHT - 12, -THICKNESS])
            screen_out();
        screen_fix_screw(width, height);
        translate([17, 15, -38 + THICKNESS])
            bnc();
    };

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([0, height - SCREEN_HEIGHT - 12, -THICKNESS])
                screen();
            screen_fix_screw(width, height);
            translate([17, 15, -38 + THICKNESS])
                bnc();
        }
    }
}

module screen_fix(width, height, depth) {
    difference() {
        translate([23, height - SCREEN_HEIGHT - THICKNESS - 18, -THICKNESS * 2])
            cube([180, SCREEN_HEIGHT + 18, THICKNESS]);
        translate([157, height - THICKNESS - 12, -THICKNESS * 2])
            cube([20, 12, THICKNESS * 2]);
        screen_fix_screw(width, height);
    }
}

module screen_fix_screw(width, height) {
    translate([32, height - 8, THICKNESS])
        screw();
    translate([200 - 2, height - 8, THICKNESS])
        screw();
    translate([32, height - SCREEN_HEIGHT - 16, THICKNESS])
        screw();
    translate([200 - 2, height - SCREEN_HEIGHT - 16, THICKNESS])
        screw();
}

module front_right(width, height, depth) {
    difference() {
        rotate([0, 0, 180])
            translate([-width, -height, 0])
                part(width, height, depth);
        translate([-width, height - SCREEN_HEIGHT - 6, 0])
            screen_in();
        translate([width - 30, THICKNESS + 3, 0])
            power_button();
        translate([10, 8, -15 + THICKNESS])
            usb();
    };

    translate([width, height - 30, -3])
        support_sonde();
    translate([width, height - 30, -39])
        support_sonde();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([width - 30, THICKNESS + 3, -17 + THICKNESS])
                power_button();
            translate([10, 8, -15 + THICKNESS])
                usb();
        }
    }
}
