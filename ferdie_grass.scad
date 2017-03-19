// Derived from http://www.thingiverse.com/thing:211643

//(mm)
Height = 95;

// (mm)
Diameter = 100;

// (mm)
WallThickness = 2.5;

// Make a round pot?
RoundPlanter = "Yes"; // [Yes, No]

//If not round then how many sides?
PlanterSides = 5;

// Try .15 - .3
sHeight = .20;

roundRes = 150;
userRes = 10;
/* error checking */
h4 = Height == 0 ? 20 : abs(Height);
radius = Diameter == 0 ? 20 : abs(Diameter / 2);
wT = WallThickness == 0 ? 2 : abs(WallThickness);
resHack = RoundPlanter == "Yes" ? roundRes : PlanterSides;
res = resHack == 0 ? 4 : abs(resHack);

offset = wT*2 + 1.0;

h2 = (h4 * sHeight) + wT;
h3 = h2 + (offset/2) + wT;
h1 = h3 - offset - wT;
r1 = radius - offset;

maxRes = 16;

faceOS = 0.01;
faceOS2 = faceOS * 2;
drainH_Hold = (h1 - 2) * 1.414;

drainH = drainH_Hold < 5 ? 5 : drainH_Hold;

iCount= res<=maxRes ? res : 6;

union(){
base();
taper();
top();
drain();
}

module drain(){
	difference(){
		cylinder(h = h1, r1 = r1, r2 = r1, $fn = res);
	
		translate([0,0,-faceOS]) 
			cylinder(h = h1 + faceOS2, r1 = r1 - wT, r2 = r1 - wT, $fn = res);
   	
		for( i = [1:iCount]){
			rotate([90,0,(360/iCount) * (i + ((iCount - 2) % 4) * 0.25) ]) 
				translate([0,(-.707*drainH),0]) 
					rotate([0,0,45]) 
						cube([drainH,drainH*.6,r1]);}
	}
}

module base(){
	difference(){
		cylinder(h = h2, r1 = radius, r2 = radius, $fn = res);

		translate([0,0,wT]) 
			cylinder(h = h2+.1, r1 = radius - wT, r2 = radius - wT, $fn = res);}
}


module top(){
	difference(){
		translate([0,0,h3]) 
			cylinder(h = h4 - h3, r1 = radius, r2 = radius, $fn = res);

		translate([0,0,h3-.1]) 
			cylinder(h = (h4 - h3) + 1.1, r1 = radius - wT, r2 = radius - wT, $fn = res);}
}

module taper(){
	translate([0,0,h1]){
        difference(){
		    cylinder(h = h3-h1, r1 = r1,    r2 = radius,    $fn = res);
		    cylinder(h = h3-h1, r1 = r1-wT, r2 = radius-wT, $fn = res);
		    translate([0,0,h3 - h1 - faceOS]) 
			    cylinder(h = 1, r1 = radius-wT, r2 = radius-wT, $fn = res);
		    translate([0,0,-faceOS]) 
			    cylinder(h = faceOS2, r1 = r1-wT, r2 = r1-wT, $fn = res);
        }
    }
}

