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
        translate([THICKNESS + 30, height - 50, 0])
            variable_alim();
        translate([THICKNESS + 35, height - 100, -26 + THICKNESS])
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
            translate([THICKNESS + 30, height - 50, -24 + THICKNESS])
                variable_alim();
            translate([THICKNESS + 35, height - 100, -26 + THICKNESS])
                fixed_alim();
        }
    }
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

    translate([width, height - 30, -6])
        support_sonde();
    translate([width, height - 30, -42])
        support_sonde();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([width - 30, THICKNESS + 3, -17 + THICKNESS])
                power_button();
            translate([21, 20, -38 + THICKNESS])
                bnc_plug();
        }
    }
}
