module variable_alim() {
    dps_screen();
    translate([25, -20, -2])
        banana_pair();
}

module dps_screen() {
    cube([72, 40, 24]);
    translate([-4, 14, 12])
        cube([4, 12, 12]);
    translate([72, 14, 12])
        cube([4, 12, 12]);
}

module fixed_alim() {
        banana_pair();
    translate([75, 0, 0])
        banana_pair();

    translate([36, -25, 9])
        power_button();

    translate([0, -20, 0])
        banana_pair();
    translate([75, -20, 0])
        banana_pair();
}

module screen_in() {
    cube([201, 115, THICKNESS]);
}

module screen_out() {
    cube([210, SCREEN_HEIGHT, THICKNESS]);
}

module screen() {
    cube([210, SCREEN_HEIGHT, THICKNESS]);
    translate([95, -5, 0])
        cube([20, 5, THICKNESS]);
}

module dps() {
    cube([93, 73, 45]);

    holes(93, 73);
}

module lm2596() {
    cube([102, 69, 20]);
    translate([12, 69, 0])
        cube([78, 11, 20]);
    translate([0, 23, -THICKNESS - 1])
        cube([88, 15, THICKNESS + 1]);

    holes(102, 69);
}

module redpitaya() {
    cube([110, 60, 25]);
    translate([30, 10, -THICKNESS - 1])
        rotate([0, 0, 45])
            cube([30, 30, THICKNESS + 1]);

    holes(90, 60);
}

module raspberry() {
    cube([90, 60, 20]);

    holes(65, 60);
}

module holes(width, height) {
    translate([4, 4, -THICKNESS])
        rotate([180, 0, 0])
            screw();

    translate([width - 4, 4, -THICKNESS])
        rotate([180, 0, 0])
            screw();

    translate([4, height - 4, -THICKNESS])
        rotate([180, 0, 0])
            screw();

    translate([width - 4, height - 4, -THICKNESS])
        rotate([180, 0, 0])
            screw();
}

module alim() {
    cube([150, 100, 50]);
    translate([150 - 15 - 60 / 2, 60 / 2 + 5, -THICKNESS])
        cylinder(THICKNESS, d=60);
}

module power_button() {
    cube([23, 30, 17]);
}

module power_plug() {
    rotate([0, -90, 0])
        cube([27.5, 50, 26]);
}

module screw() {
    cylinder(5, d=9, $fn=6);
    translate([0, 0, -20])
        cylinder(20, d=5, $fn=20);
}

module hinge() {
    cube([20, 30, 2]);

    translate([4, 6, 0])
        screw();
    translate([16, 6, 0])
        screw();
    translate([4, 24, 0])
        screw();
    translate([16, 24, 0])
        screw();
}

module lock() {
    translate([0, 25, 0])
        screw();
    translate([40, 25, 0])
        screw();
}
