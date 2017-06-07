module screw_support() {
    difference() {
        union() {
            translate([10, 12, 0])
                cylinder(8, r=12);
            cube([12, 12, 8]);
        };
        translate([-12, 0, 0])
            cube([12, 24, 12]);
        translate([0, 12, 0])
            cube([24, 12, 12]);
        translate([6, 6, 5])
            screw();
    };

    if (DISPLAY_BLOCKS) {
        color("red")
            translate([6, 6, 5])
                screw();
    }
}

module support_sonde() {
    translate([5, 0, 0]) {
        rotate([-90, 0, 0]) {
            difference() {
                base_support();
                translate([15, 12, -5])
                    cylinder(10, d=14);
            }
        }
    }
}

module support_banana() {
    translate([5, 0, 0]) {
        rotate([-90, 0, 0]) {
            difference() {
                base_support();
                rotate([0, 180, 0])
                    translate([-12, 12, 0])
                        screw();
            }

            if (DISPLAY_BLOCKS) {
                color("red")
                    rotate([0, 180, 0])
                    translate([-12, 12, 0])
                    screw();
            }
        }
    }
}

module base_support() {
    difference() {
        union() {
            cube([21, 24, 5]);
            rotate([0, 90, 0])
                cube([20, 24, 20]);
            rotate([0, -90, 0])
                translate([-20, 0, 0])
                    cube([25, 24, 5]);
        }
        rotate([90, 90, 0])
            translate([20, 20, -24])
                cylinder(24, d=40);
        rotate([0, 90, 0])
            translate([12, 12, 0])
                screw();
    }

    if (DISPLAY_BLOCKS) {
        color("red")
            translate([0, 12, -12])
                rotate([0, 90, 0])
                    screw();
    }
}
