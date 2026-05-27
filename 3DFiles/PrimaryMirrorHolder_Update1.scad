$fn = 100;

holder_height = 8;
base_height = 6;

module base()
{
 
    linear_extrude(height = holder_height)
    {

        square([158,20],center=true);
        rotate([0,0,120]) square([158,20],center=true);
        rotate([0,0,240]) square([158,20],center=true);
    }
 
    difference()
    {
         linear_extrude(height = holder_height) circle(d=160);
         linear_extrude(height = holder_height) circle(d=140);
    } 
}

module mirror_to_base_fixation()
{
    difference()
    {
        cylinder(h=1, r=165/2);
        cylinder(h=1, r=156/2);
    }
    difference()
    {
        cylinder(h=35, r=164.5/2);
        cylinder(h=35, r=160.5/2);
        translate([0,0,25]) cube([70,300,35],true);
        rotate([0,0,60]) translate([0,0,25]) cube([70,300,35],true);
        rotate([0,0,120]) translate([0,0,25]) cube([70,300,35],true);
    }
}
 
module vijsentry()
{
    translate([-60,0,0])
    {
        translate([0,0,3]) 
            linear_extrude(height = 5)  
                scale([6,6,0]) 
                    polygon([
                        [1,0],
                        [0.5,0.87],
                        [-0.5,0.87],
                        [-1,0],
                        [-0.5,-0.87],
                        [+0.5,-0.87],
                        [1,0]]);
                        
        translate([0,0,2]) cylinder(h=10,r=3.2,center=true);
    }
}

module vijsgeleider()
{
    translate([-60,0,0])
    {
        translate([0,0,5]) cylinder(h=10,r=3.2,center=true);
    }
}    

module gluestamps()
{
    translate([60,0,0]) cylinder(h=2, r = 5, center = true);
}


// de mirror plate, hierop wordt de spiegel vastgemaakt
module mirror_plate()
{
    difference()
    {
        base();
        rotate([0,0,  0]) vijsentry();
        rotate([0,0,120]) vijsentry();
        rotate([0,0,240]) vijsentry();
        cylinder(h=2,r = 3, center=true);
    }

    translate([0,0,holder_height]) rotate([0,0,   0]) gluestamps();
    translate([0,0,holder_height]) rotate([0,0, 120]) gluestamps();
    translate([0,0,holder_height]) rotate([0,0, 240]) gluestamps();
}
   
// dit is het vijsgat test print
module vijsgat()
{
    size = 14;
    difference()
    {
        translate ([0, 0, 4]) 
            cube([size,size,8],center = true);
        translate([50,0,0])  vijsentry();
    }
}

module vijsgat_draaibaar()
{
    difference()
    {
        cylinder(h=10,r=13.2, center=true);
        cylinder(h=10,r=6.8, center=true);
        rotate([0,0,-8]) translate([20,0,0]) cube(40,center=true);
        rotate([0,0,130]) translate([20,0,0]) cube(40,center=true);
    }     
    rotate([0,0, 40]) translate([50,0,-5]) vijsgeleider();
    rotate([0,0, 80]) translate([50,0,-5]) vijsgeleider();
}


hoogte_mirror_base = 80;
binnen_diameter = 201.5;
buiten_diameter = 208;

module mirror_base()
{
    // zeshoek
    difference()
    {
        union()
        {
            //translate([0,0,base_height]) 
            linear_extrude(height = 2) 
                circle(d=buiten_diameter - 2);

            linear_extrude(height = base_height)
            { 
                square([198,20],center=true);
                rotate([0,0,120]) square([198,20],center=true);
                rotate([0,0,240]) square([198,20],center=true);
            }
        }
        rotate([0,0,   0]) vijsgeleider();
        rotate([0,0, 120]) vijsgeleider();
        rotate([0,0, 240]) vijsgeleider();
        translate([0,0,6]) rotate([180,0,0]) translate([60,0,0]) vijsentry();
    }
    
    // base onderste cirkel, versteviging
    difference()
    {
         linear_extrude(height = base_height) circle(d=buiten_diameter);
         linear_extrude(height = base_height) circle(d=180);
    } 
    
    // buitenste cirkel
    {
        difference()
        {
            linear_extrude(height = hoogte_mirror_base) circle(d=buiten_diameter);
            linear_extrude(height = hoogte_mirror_base) circle(d=binnen_diameter);
            // schroefgaten
            rotate([0,0,90]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,180]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,270]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,0]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,90]) translate([binnen_diameter/2,0,60]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,180]) translate([binnen_diameter/2,0,60]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,270]) translate([binnen_diameter/2,0,60]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,0]) translate([binnen_diameter/2,0,60]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
        } 
    }

    // versterking onderaan
    /*
    {
        difference()
        {
             linear_extrude(height = 10) circle(d=binnen_diameter);
             linear_extrude(height = 10) circle(d=binnen_diameter-5);
        } 
    }   
    */
    
    // alu bar holders
    rotate([0,0,45]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_mirror_base/2]) alu_bar_holder();
    rotate([0,0,45+90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_mirror_base/2]) alu_bar_holder();
    rotate([0,0,45+180]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,hoogte_mirror_base/2]) alu_bar_holder();
    rotate([0,0,45-90]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,hoogte_mirror_base/2]) alu_bar_holder();
    
    // versterking aan de top
    difference()
    {
        translate([0,0,hoogte_mirror_base])
            rotate([0,180,0])
                difference()
                {
                    cylinder(h=10, r1 = buiten_diameter / 2 + 3,r2= buiten_diameter / 2);
                    cylinder(h=10, r = buiten_diameter / 2, center=false);
                }
    
        rotate([0,0,45]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_mirror_base/2]) cube([alu_holder_size,alu_holder_size,100],center=true);
        rotate([0,0,45+90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_mirror_base/2]) cube([alu_holder_size,alu_holder_size,100],center=true);
        rotate([0,0,45+180]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_mirror_base/2]) cube([alu_holder_size,alu_holder_size,100],center=true);
        rotate([0,0,45-90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_mirror_base/2]) cube([alu_holder_size,alu_holder_size,100],center=true);
    }
}

alu_holder_size = 20.1;
alu_holder_thickness = 3;

module alu_bar_holder()
{
    difference()
    {
        cube([alu_holder_size + 2*alu_holder_thickness,
              alu_holder_size + 2*alu_holder_thickness,
              hoogte_mirror_base],center = true);
        translate([0,0,alu_holder_thickness]) cube([alu_holder_size, alu_holder_size, hoogte_mirror_base], center = true);
        //schroefgaatje
        translate([0,0,0]) rotate([90,0,0])  cylinder(h=alu_holder_size+2*alu_holder_thickness + 2, r=2.5,center=true);
        translate([0,0,-hoogte_mirror_base/2])cylinder(h=10, r=2.5,center=true);
    }
}
module alu_bar_hol(hoogte)
{
    dikte_schroefgaatje = 3.0;
    difference()
    {
        cube([alu_holder_size + 2*alu_holder_thickness,
              alu_holder_size + 2*alu_holder_thickness,
              hoogte],center = true);
        cube([alu_holder_size, alu_holder_size, hoogte], center = true);
        //schroefgaatje
        translate([0,0,hoogte/3]) rotate([90,0,0])  cylinder(h=alu_holder_size+2*alu_holder_thickness + 2, r=dikte_schroefgaatje,center=true);
        translate([0,0,0]) rotate([90,0,0])  cylinder(h=alu_holder_size+2*alu_holder_thickness + 2, r=dikte_schroefgaatje,center=true);
        translate([0,0,-hoogte/3]) rotate([90,0,0])  cylinder(h=alu_holder_size+2*alu_holder_thickness + 2, r=2.5,center=true);
        translate([0,0,-hoogte/2]) cylinder(h=10, r=dikte_schroefgaatje,center=true);
    }
}

hoogte_sec_mirror_base = 250; // max print hoogte //35 + 140;
sec_base_height = 5;
module Small_mirror_base()
{
    // base
    translate([0,0,hoogte_sec_mirror_base-10]) 
    {
        difference() {
            union(){
                translate([0,0,5]) cylinder(h=10, r = 35/2, center = true);
                translate([0,-1,0]) cube([buiten_diameter/2,2,10],center=false);
                rotate([0,0,120]) translate([0,-1,0]) cube([buiten_diameter/2,2,10],center=false);
                rotate([0,0,240]) translate([0,-1,0])  cube([buiten_diameter/2,2,10],center=false);  
                
                
            }
            translate([0,0,8]) rotate([0,180,0]) translate([60,0,0]) vijsentry();

            rotate([0,0,  60]) translate([0,0,5]) vijsgat_draaibaar();
            rotate([0,0, 180]) translate([0,0,5]) vijsgat_draaibaar();
            rotate([0,0, 300]) translate([0,0,5]) vijsgat_draaibaar();
        }
    }

    // buitenste cirkel
    speling = 5;
    // translate([buiten_diameter/2-10,-62/2,hoogte_sec_mirror_base-54-31]) rotate([0,90,0]) cube([speling,62,speling]);
    {
        difference()
        {
            union(){
                cylinder(h=hoogte_sec_mirror_base,r=buiten_diameter/2);
                translate([buiten_diameter/2-14+6,-40,hoogte_sec_mirror_base-55-80-80]) 
                {
                    cube([10,80,80]);
                    translate([0,+60,+15]) rotate([0,90,0]) cylinder(h=12,r=3);
                    translate([0,+20,+15]) rotate([0,90,0]) cylinder(h=12,r=3);
                    translate([0,+20,+65]) rotate([0,90,0]) cylinder(h=12,r=3);
                    translate([0,+60,+65]) rotate([0,90,0]) cylinder(h=12,r=3);
                }
                rotate([0,0,180]) translate([0,0,hoogte_sec_mirror_base-55-31-45]) color([1,0,0])  eye_piece_connector_enforcement();
            }
            cylinder(h=hoogte_sec_mirror_base+20,r=binnen_diameter/2);
            // schroefgaten
            rotate([0,0,90]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,180]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,270]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
            rotate([0,0,0]) translate([binnen_diameter/2,0,20]) rotate([0,90,0]) cylinder(h=10,r=2,center=true);
                translate([100,0,hoogte_sec_mirror_base-54-31]) rotate([0,90,0]) cylinder(h=250,r=31,center=true);
                translate([100,0,hoogte_sec_mirror_base-54-31-speling]) rotate([0,90,0]) cylinder(h=250,r=31,center=true);
                translate([buiten_diameter/2-10,-62/2,hoogte_sec_mirror_base-54-31]) rotate([0,90,0]) cube([speling,62,speling]);

        } 
    }
    
    // alu bar holders
    rotate([0,0,45]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_sec_mirror_base/2]) alu_bar_hol(hoogte_sec_mirror_base);
    rotate([0,0,45+90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_sec_mirror_base/2]) alu_bar_hol(hoogte_sec_mirror_base);
    rotate([0,0,45+180]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,hoogte_sec_mirror_base/2]) alu_bar_hol(hoogte_sec_mirror_base);
    rotate([0,0,45-90]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,hoogte_sec_mirror_base/2]) alu_bar_hol(hoogte_sec_mirror_base);

//    rotate([0,0,45]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,-69]) alu_bar_hol(140);
//    rotate([0,0,45+90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,-69]) alu_bar_hol(140);
//    rotate([0,0,45+180]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,-69  ]) alu_bar_hol(140);
//    rotate([0,0,45-90]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,-69]) alu_bar_hol(140);
    
    // versterking aan de top
    color([255,0,0]) difference()
    {
        translate([0,0,hoogte_sec_mirror_base])
            rotate([0,180,0])
                difference()
                {
                    cylinder(h=10, r1 = buiten_diameter / 2 + 3,r2= buiten_diameter / 2);
                    cylinder(h=10, r = buiten_diameter / 2 - 10, center=false);
                }
    
        rotate([0,0,45]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_sec_mirror_base/2]) cube([alu_holder_size,alu_holder_size,hoogte_sec_mirror_base],center=true);
        rotate([0,0,45+90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_sec_mirror_base/2]) cube([alu_holder_size,alu_holder_size,hoogte_sec_mirror_base],center=true);
        rotate([0,0,45+180]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_sec_mirror_base/2]) cube([alu_holder_size,alu_holder_size,hoogte_sec_mirror_base],center=true);
        rotate([0,0,45-90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,hoogte_sec_mirror_base/2]) cube([alu_holder_size,alu_holder_size,hoogte_sec_mirror_base],center=true);
    }
}

module secondary_mirror()
{
    difference()
    {
        union()
        {
            color ([1,0,0]) rotate([0,0,180]) difference()
            {
                cylinder(h=8, r=33/2);
                
                translate([-10,0,0]) rotate([0,0,   30]) translate([60,0,0]) vijsentry();
                rotate([0,0, 120]) translate([-10,0,0]) rotate([0,0,   30]) translate([60,0,0]) vijsentry();
                rotate([0,0, 240]) translate([-10,0,0]) rotate([0,0,   30]) translate([60,0,0]) vijsentry();
                
                rotate([0,0, 60]) translate([10,-3.2,0]) cube([10,6.2,8]);
                rotate([0,0,180]) translate([10,-3.2,0]) cube([10,6.2,8]);
                rotate([0,0,-60]) translate([10,-3.2,0]) cube([10,6.2,8]);

            }
            
            // 45° plateautje
            translate([0,0,25]) rotate([0,0,0]) difference()
            {
                cylinder(h=60, r = 33/2);
                translate([20,0,-30]) rotate([0,45,0]) cube(100, center=true);
                translate([-20,0,80]) rotate([0,45,0]) cube(100, center=true);
            }

            // 45° plateautje - spiegeltje
            /*
            translate([0,0,35]) difference()
            {
                cylinder(h=60, r = 35/2);
                translate([20,0,-30]) rotate([0,45,0]) cube(100, center=true);
                translate([-20,0,80]) rotate([0,45,0]) cube(100, center=true);
            } 
            */   
            // center versterking
            rotate([0,0,180]) difference()
            {
                union()
                {
                    cylinder(h=90, r=2.5);
                    rotate([0,0,   0]) translate([0,-1,0]) cube([33/2,2,90 ],center=false);
                    rotate([0,0, 120]) translate([0,-1,0]) cube([33/2,2,90 ],center=false);
                    rotate([0,0, 240]) translate([0,-1,0]) cube([33/2,2,90 ],center=false);

                }
                color([0,1,0]) translate([25,0,100]) rotate([0,45,0]) cube(100, center=true);
            }        
            //rotate([0,0,180]) color([0,1,0]) translate([25,0,100]) rotate([0,-45,0]) cube(100, center=true);
        }
                translate([0,0,-0.6]) cylinder(h=1.2,r=5);

    }
    translate([0,0,1.2]) scale([1,1,0.4]) sphere(3);
}

// todo : eye scope
hoogte_eye_piece = 80;
hoogte_eye_piece2 = 90;
module eye_piece_connector()
{

    // buitenste cirkel

    translate([0,0,-hoogte_eye_piece/2])
    {
    //    translate([0,0,0]) rotate([0,90,0]) cylinder(h=250,r=31,center=true);

        difference()
        {
            union()
            {
                difference()
                {
                    linear_extrude(height = hoogte_eye_piece) circle(d=buiten_diameter);
                    linear_extrude(height = hoogte_eye_piece) circle(d=binnen_diameter);
                    // schroefgaten
                    rotate([0,0,35.8]) translate([0,-buiten_diameter/2,0]) cube(buiten_diameter);
                    rotate([0,0,-35.8]) translate([0,-buiten_diameter/2,0]) cube(buiten_diameter);

                    translate([0,0,0]) rotate([0,90,0]) cylinder(h=250,r=31,center=true);
                } 
                rotate([0,0,45]) translate([13.5,buiten_diameter/2-3,0]) eye_piece_holder_sides();
                rotate([0,0,180-45]) translate([-16.5,buiten_diameter/2-3,0]) eye_piece_holder_sides();
            }
            rotate([0,0,45+90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,20]) alu_bar_hol(120);
            rotate([0,0,45+180]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,20  ]) alu_bar_hol(120);
        }
    //rotate([0,0,45+90]) translate([buiten_diameter/2 + alu_holder_size/2 + 2,0,20]) alu_bar_hol(120);
    //rotate([0,0,45+180]) translate([buiten_diameter/2 + alu_holder_size/2+2,0,20  ]) alu_bar_hol(120);
         //   rotate([0,90,0]) cylinder(h=250,r=31,center=true);
    }
}

module eye_piece_connector_enforcement()
{

    // buitenste cirkel

    {
    //    translate([0,0,0]) rotate([0,90,0]) cylinder(h=250,r=31,center=true);

        difference()
        {
            union()
            {
                difference()
                {
                    linear_extrude(height = hoogte_eye_piece2) circle(d=buiten_diameter+2);
                    linear_extrude(height = hoogte_eye_piece2) circle(d=binnen_diameter);
                    // schroefgaten
                    rotate([0,0,48]) translate([0,-buiten_diameter/2,0]) cube(buiten_diameter);
                    rotate([0,0,-48]) translate([0,-buiten_diameter/2,0]) cube(buiten_diameter);

                } 
            }
        }
    }
}

module eye_piece_holder_sides()
{
    difference(){
        cube([3,20,hoogte_eye_piece]);
        translate([-5,11,hoogte_eye_piece*2/20 ]) rotate([0,90,0]) cylinder(h=10,r=2);
        translate([-5,11,hoogte_eye_piece*7/20 ])  rotate([0,90,0]) cylinder(h=10,r=2);
        translate([-5,11,hoogte_eye_piece*13/20 ])  rotate([0,90,0]) cylinder(h=10,r=2);
        translate([-5,11,hoogte_eye_piece*18/20 ])  rotate([0,90,0]) cylinder(h=10,r=2);
    }
}


//wat moet er gerendered worden ?
//vijsgat();
Stranslate([0,0,-30]) rotate ([180,0,0]) mirror_plate();
//mirror_base();
//Small_mirror_base();
//translate([0,0,15]) rotate([180,0,0]) secondary_mirror();

//rotate([0,0,180]) translate([0,0,-41]) eye_piece_connector_enforcement();
 //       rotate([0,0, 60]) translate([10,-3,0]) cube([10,6,8])
//mirror_to_base_fixation();


//alu_bar_hol();
//alu_bar_holder()
//mirror_plate();
//testbase();