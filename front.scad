module front() {
    translate([-WIDTH/3, 0, DEPTH / 2])
        front_left(WIDTH/3, HEIGHT, DEPTH/2);

    translate([0, 0, DEPTH / 2])
        front_middle(WIDTH/3, HEIGHT, DEPTH/2);

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
    screen_size=126;

    difference() {
        union() {
            middle_part(width, height, depth);
            translate([THICKNESS, height - screen_size - THICKNESS - 15, -THICKNESS])
                cube([width - THICKNESS, screen_size + 15, THICKNESS * 2]);
        };
        translate([-THICKNESS + 6, height - screen_size - 6, 0])
            screen_in();
        translate([0, height - screen_size - 12, -THICKNESS])
            screen_out();
        translate([15, 18, 0])
            bnc();
        translate([width - 25, 10, -15 + THICKNESS])
            usb();
    };

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([0, height - screen_size - 12, -THICKNESS])
                screen();
            translate([15, 18, -38 + THICKNESS])
                bnc();
            translate([width - 25, 10, -15 + THICKNESS])
                usb();
        }
    }
}

module front_right(width, height, depth) {
    screen_size=126;

    difference() {
        rotate([0, 0, 180])
            translate([-width, -height, 0])
                part(width, height, depth);
        translate([-width, height - screen_size - 6, 0])
            screen_in();
        translate([width - 30, THICKNESS + 3, 0])
            power_button();
    };

    translate([width, height - 30, -3])
        support_sonde();
    translate([width, height - 30, -39])
        support_sonde();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([width - 30, THICKNESS + 3, -17 + THICKNESS])
                power_button();
        }
    }
}
