module banana_pair() {
    margin = 19;

    banana_plug();
    translate([margin, 0, 0])
        banana_plug();
}

module banana_plug() {
    cylinder(26, d=13);
}

module bnc() {
    for (i = [0:3]) {
        translate([32 * i, 0, 0])
            bnc_plug();
    }

    translate([132, 0, 0])
        bnc_plug();
}

module bnc_plug() {
    cylinder(38, d=14);
}

module usb() {
    cube([14, 15, 15]);
}
