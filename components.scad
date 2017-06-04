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

module screen_in() {
    cube([min(201, WIDTH/2), 115, THICKNESS * 3]);
}

module screen_out() {
    cube([min(210, WIDTH/2), 126, THICKNESS]);
}

module screen() {
    cube([210, 126, THICKNESS]);
}

module dps() {
    cube([93, 73, 45]);
}

module lm2596() {
    cube([102, 80, 20]);
    translate([0, 23, -THICKNESS - 1])
        cube([88, 15, THICKNESS + 1]);
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
    translate([0, 0, -30])
        cylinder(30, d=5, $fn=20);
}
