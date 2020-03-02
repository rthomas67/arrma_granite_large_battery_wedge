batteryCompartmentWidth=51;
batteryCompartmentLength=141.5;
batteryCompartmentLedgeHeightInner=35;
batteryCompartmentLedgeHeightOuter=22;
batteryCompartmentLedgeWidthOuter=25;

wedgeOverhang=19;
wedgeLength=batteryCompartmentLength+wedgeOverhang;
wedgeLowEndHeight=5;
wedgeHighEndHeight=40;

footHeight=20;

footTopHeight=wedgeLowEndHeight+footHeight;

wedgeAngle=atan(wedgeHighEndHeight/wedgeLength);

footBottomLength=sin(wedgeAngle)*footTopHeight;

overlap=0.01;
$fn=50;

rotate([90,0,90])
difference() {
    union() {
        hull() {
            cube([1,1,wedgeLowEndHeight]);
            translate([wedgeLength-1,0,0])
                cube([1,1,wedgeHighEndHeight]);
            translate([0,batteryCompartmentWidth-1,0])
                cube([1,1,wedgeLowEndHeight]);
            translate([wedgeLength-1,batteryCompartmentWidth-1,0])
                cube([1,1,wedgeHighEndHeight]);
        }
        hull() {
            cube([1,batteryCompartmentWidth,footTopHeight]);
            translate([footBottomLength,0,0])
                cube([1,batteryCompartmentWidth,1]);
        }
    }
    // cut out shape under ledge
    translate([batteryCompartmentLength,-overlap,-overlap]) {
        union() {
            cube([wedgeOverhang+overlap, batteryCompartmentWidth, batteryCompartmentLedgeHeightOuter]);
            hull() {
                // 1x1 posts in the middle, where the slope goes up
                translate([-overlap,batteryCompartmentLedgeWidthOuter,-overlap]) // +y-axis low/outer height
                    cube([1,1,batteryCompartmentLedgeHeightOuter+overlap*2]);
                translate([wedgeOverhang-1+overlap,batteryCompartmentLedgeWidthOuter,-overlap]) // +x-axis and +y-axis low/outer height
                    cube([1+overlap,1+overlap,batteryCompartmentLedgeHeightOuter+overlap*2]);
                // 1x1 posts at the high corners    
                translate([0,batteryCompartmentWidth-1+overlap,-overlap]) // +y-axis
                    cube([1+overlap,1+overlap,batteryCompartmentLedgeHeightInner+overlap*2]);
                translate([wedgeOverhang-1+overlap,batteryCompartmentWidth-1+overlap,-overlap]) // + both
                    cube([1+overlap,1+overlap,batteryCompartmentLedgeHeightInner+overlap*2]);
            }
        }
    }
}