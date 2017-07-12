module back() {
    translate([-WIDTH/3, 0, -DEPTH / 2])
        back_left(WIDTH/3, HEIGHT, DEPTH/2);

    translate([0, 0, -DEPTH / 2])
        back_middle(WIDTH/3, HEIGHT, DEPTH/2);

    translate([WIDTH/3, 0, -DEPTH / 2])
        back_right(WIDTH/3, HEIGHT, DEPTH/2);
}

module back_left(width, height, depth) {
    difference() {
        rotate([180, 0, 0])
            translate([0, -height, 0])
                part(width, height, depth);
            translate([27, THICKNESS + 5, THICKNESS + 5])
                power_plug();
            translate([(width - 102) / 2, THICKNESS + 5, 0])
                lm2596();
    };

    translate([0, height - 30, depth - 36])
        rotate([180, 0, 180])
            support_banana();
    translate([0, height - 30, depth - 36 * 2])
        rotate([180, 0, 180])
            support_banana();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([27, THICKNESS + 5, THICKNESS + 5])
                power_plug();
            translate([(width - 93) / 2, height - 73 - THICKNESS, 0])
                dps();
            translate([(width - 102) / 2, THICKNESS + 5, 0])
                lm2596();
        };
    }
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

module back_right(width, height, depth) {
    difference() {
        rotate([0, 180, 0])
            translate([-width, 0, 0])
                part(width, height, depth);
        translate([width - 150 - THICKNESS, THICKNESS, 0])
            alim();
    };

    translate([width, height - 30, depth - 12])
        support_sonde();
    translate([width, height - 30, depth - 48])
        support_sonde();

    if (DISPLAY_BLOCKS) {
        color("red") {
            translate([width - 150 - THICKNESS, THICKNESS, 0])
                alim();
        }
    }
}
