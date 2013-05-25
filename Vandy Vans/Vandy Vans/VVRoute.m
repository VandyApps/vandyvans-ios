//
//  VVRoute.m
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVRoute.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GMSMarker+ConstructorAdditions.h"

@implementation VVRoute

+ (NSArray *)markersForRouteName:(NSString *)routeName {
    NSMutableArray *mutableMarkers = [[NSMutableArray alloc] init];
    
    // Initialize Branscomb Quad stop.
    GMSMarker *branscombQuadMarker = [GMSMarker markerWithLatitude:36.1451786450032 longitude:-86.805682182312 title:@"Branscomb Quad" animated:YES];
    
    // Initialize Carmichael Towers stop.
    GMSMarker *carmichaelTowersMarker = [GMSMarker markerWithLatitude:36.1472839210716 longitude:-86.8059504032135 title:@"Carmichael Towers" animated:YES];
    
    // Initialize Murray House stop.
    GMSMarker *murrayHouseMarker = [GMSMarker markerWithLatitude:36.1399888548681 longitude:-86.7964553833008 title:@"Murray House" animated:YES];
    
    // Initialize Highland Quad stop.
    GMSMarker *highlandQuadMarker = [GMSMarker markerWithLatitude:36.1408206306468 longitude:-86.8065512180328 title:@"Highland Quad" animated:YES];
    
    [mutableMarkers addObject:branscombQuadMarker];
    [mutableMarkers addObject:carmichaelTowersMarker];
    [mutableMarkers addObject:murrayHouseMarker];
    [mutableMarkers addObject:highlandQuadMarker];
    
    if (![routeName isEqualToString:@"Red"]) {
        // Initialize Kissam Quad stop.
        GMSMarker *kissamQuadMarker = [GMSMarker markerWithLatitude:36.1490685964468 longitude:-86.8026459217072 title:@"Kissam Quad" animated:YES];
        
        [mutableMarkers addObject:kissamQuadMarker];
        
        if ([routeName isEqualToString:@"Green"]) {
            // Initialize Vanderbilt Police Station stop.
            GMSMarker *policeStationMarker = [GMSMarker markerWithLatitude:36.1433765531155 longitude:-86.8107461929321 title:@"Vanderbilt Police Station" animated:YES];
            
            // Initialize Vanderbilt Bookstore stop.
            GMSMarker *bookstoreMarker = [GMSMarker markerWithLatitude:36.1455078688563 longitude:-86.8083053827286 title:@"Vanderbilt Bookstore" animated:YES];
            
            // Initialize Terrace Place Garage stop.
            GMSMarker *terracePlaceGarageMarker = [GMSMarker markerWithLatitude:36.14995225563 longitude:-86.7994487285614 title:@"Terrace Place Garage" animated:YES];
            
            // Initialize Wesley Place Garage stop.
            GMSMarker *wesleyPlaceGarageMarker = [GMSMarker markerWithLatitude:36.1459973701886 longitude:-86.799556016922 title:@"Wesley Place Garage" animated:YES];
            
            // Initialize Blair School of Music stop.
            GMSMarker *blairSchoolOfMusicMarker = [GMSMarker markerWithLatitude:36.1389231292643 longitude:-86.805859208107 title:@"Blair School of Music" animated:YES];
            
            // Initialize McGugin Center stop.
            GMSMarker *mcguginCenterMarker = [GMSMarker markerWithLatitude:36.142900031513 longitude:-86.8079996109009 title:@"McGugin Center" animated:YES];
            
            // Initialize Blakemore House stop.
            GMSMarker *blakemoreHouseMarker = [GMSMarker markerWithLatitude:36.14276140650328 longitude:-86.81162595748901 title:@"Blakemore House" animated:YES];
            
            [mutableMarkers addObject:policeStationMarker];
            [mutableMarkers addObject:bookstoreMarker];
            [mutableMarkers addObject:terracePlaceGarageMarker];
            [mutableMarkers addObject:wesleyPlaceGarageMarker];
            [mutableMarkers addObject:blairSchoolOfMusicMarker];
            [mutableMarkers addObject:mcguginCenterMarker];
            [mutableMarkers addObject:blakemoreHouseMarker];
        }
    } else {
        // Initialize North House stop.
        GMSMarker *northHouseMarker = [GMSMarker markerWithLatitude:36.1414357924771 longitude:-86.7998135089874 title:@"North House" animated:YES];
        
        // Initialize Medical Center stop.
        GMSMarker *medicalCenterMarker = [GMSMarker markerWithLatitude:36.142779 longitude:-86.801205 title:@"Medical Center" animated:YES];
        
        [mutableMarkers addObject:northHouseMarker];
        [mutableMarkers addObject:medicalCenterMarker];
    }
    
    return [mutableMarkers copy];
}

+ (GMSPolyline *)polylineForRouteName:(NSString *)routeName {
    GMSPolyline *routePolyline;
    GMSMutablePath *routePath = [GMSMutablePath path];
    UIColor *routeColor;
    
    if ([routeName isEqualToString:@"Blue"]) {
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144863,-86.806782)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145217,-86.806064)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145478,-86.805525)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145542,-86.805437)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145794,-86.804904)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146322,-86.805296)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146838,-86.805682)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147319,-86.806036)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147901,-86.806451)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148118,-86.806012)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148808,-86.804536)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149496,-86.803156)]; // West End connection
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149211,-86.802951)]; // Beginning of circle
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149193,-86.802979)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149162,-86.803008)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149117,-86.803019)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149087,-86.803011)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149058,-86.802993)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148898,-86.802873)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148652,-86.802683)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148257,-86.802407)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148221,-86.802354)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148206,-86.802289)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148206,-86.802258)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148212,-86.802223)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14822,-86.802206)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148239,-86.802179)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148258,-86.802162)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148291,-86.802147)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148346,-86.802133)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148414,-86.802163)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14876,-86.802435)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149141,-86.80272)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149186,-86.802764)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149212,-86.802806)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149222,-86.802854)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149222,-86.8029)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149211,-86.802951)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149496,-86.803156)]; // End of Kissam turn...West End connection
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150025,-86.802069)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150231,-86.801652)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150455,-86.801198)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149504,-86.800495)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148934,-86.800063)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148838,-86.799997)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148489,-86.79974)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148323,-86.799612)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148033,-86.799443)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147951,-86.799404)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147798,-86.799362)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147579,-86.799316)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147335,-86.799356)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147072,-86.799395)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146604,-86.799469)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146438,-86.799494)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146062,-86.799548)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145604,-86.799618)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14506,-86.799698)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144821,-86.799736)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14454,-86.799778)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144381,-86.799802)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144081,-86.799844)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14407,-86.799752)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144049,-86.799549)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144018,-86.799236)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143948,-86.79849)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143902,-86.797975)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143869,-86.797606)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143814,-86.797054)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143756,-86.796501)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143682,-86.795851)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143663,-86.795684)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143102,-86.795796)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142663,-86.795877)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142313,-86.795943)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141764,-86.79605)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141033,-86.79619)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140354,-86.796319)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140091,-86.796371)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139672,-86.796453)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139064,-86.796568)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.13914,-86.797159)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139117,-86.79721)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.13908,-86.797231)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138969,-86.797259)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138641,-86.797306)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138563,-86.797335)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138524,-86.797385)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138514,-86.797471)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138563,-86.797919)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138162,-86.797986)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137312,-86.798142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137377,-86.798789)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137425,-86.799238)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137474,-86.799695)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137534,-86.800314)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137582,-86.800759)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137648,-86.801297)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137705,-86.801829)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137734,-86.802282)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1378,-86.802874)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137834,-86.803186)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137952,-86.804316)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138244,-86.807146)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138745,-86.807076)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139178,-86.807015)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140031,-86.806901)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140246,-86.806871)]; // Start of Morgan/Lewis
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1403,-86.806691)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140317,-86.806662)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140345,-86.806629)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140384,-86.806606)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140425,-86.806592)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140588,-86.806555)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14066,-86.806545)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140727,-86.806545)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140759,-86.806551)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140795,-86.806567)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140843,-86.806602)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140892,-86.806655)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140922,-86.806692)]; // End of Morgan/Lewis turn
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140971,-86.806768)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141041,-86.806759)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141547,-86.806688)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142297,-86.806589)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142725,-86.806531)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143209,-86.806467)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143947,-86.806359)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1442,-86.806327)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144254,-86.806337)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144298,-86.806357)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144488,-86.806494)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144694,-86.806645)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144863,-86.806782)];
        
        routeColor = [UIColor blueColor];
    } else if ([routeName isEqualToString:@"Red"]) {
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145791,-86.804902)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146823,-86.805668)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147022,-86.805814)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147234,-86.805968)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147279,-86.806001)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147348,-86.806058)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147452,-86.806125)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147851,-86.806409)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147902,-86.806445)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148115,-86.806016)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148252,-86.805724)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148336,-86.805546)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14845,-86.8053)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148809,-86.804536)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149218,-86.803723)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149328,-86.803502)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14944,-86.803273)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149569,-86.803007)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149693,-86.802751)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149832,-86.802464)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149928,-86.802268)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150151,-86.801816)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150456,-86.801197)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150045,-86.800895)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149503,-86.800493)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149159,-86.800233)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148938,-86.800064)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148851,-86.800006)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14839,-86.799661)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14833,-86.799616)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148275,-86.799584)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148211,-86.799547)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148107,-86.799486)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148023,-86.799437)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147951,-86.799404)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147805,-86.799362)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147587,-86.799317)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147182,-86.79938)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146779,-86.799442)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146591,-86.799471)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146063,-86.799549)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145739,-86.799599)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145357,-86.799656)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144812,-86.799737)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144341,-86.799807)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14408,-86.799846)]; // Turn off 21st onto Edgehill coming from West End
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143638,-86.799917)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143159,-86.799994)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142786,-86.800056)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142786,-86.800054)]; // Beginning of North turn
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14278,-86.799926)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142772,-86.799777)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142758,-86.799724)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142725,-86.799695)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142676,-86.799684)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142315,-86.799724)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141527,-86.799796)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141502,-86.799805)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141485,-86.799814)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141468,-86.799837)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141463,-86.799855)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141463,-86.799902)]; // End of North turn
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141507,-86.800229)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140704,-86.800351)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140142,-86.800416)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139609,-86.800478)]; // Start of Med Center loop on 21st end
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139685,-86.801148)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139748,-86.801669)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140473,-86.801557)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141057,-86.801476)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142309,-86.801312)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142631,-86.80127)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142752,-86.801221)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142793,-86.801185)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142813,-86.801158)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142826,-86.801132)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142848,-86.80105)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142862,-86.800947)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142863,-86.800819)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142856,-86.80072)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142817,-86.800419)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142786,-86.800055)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14408,-86.799846)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143877,-86.797675)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143664,-86.795688)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141442,-86.79611)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139988,-86.79639)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139672,-86.796451)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139065,-86.796568)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139144,-86.797167)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139118,-86.79721)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139074,-86.797236)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138966,-86.797259)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138645,-86.797304)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138602,-86.797316)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138561,-86.797337)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138525,-86.797389)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138516,-86.797475)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138563,-86.797919)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138239,-86.797974)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137872,-86.798046)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137313,-86.798155)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137392,-86.798914)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137489,-86.799845)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137555,-86.800501)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137583,-86.800761)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137636,-86.801179)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137705,-86.801832)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137736,-86.802287)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137811,-86.802979)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137853,-86.803371)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138019,-86.80497)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138097,-86.805725)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138211,-86.806828)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138242,-86.807147)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139178,-86.807015)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140234,-86.806876)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140246,-86.806871)]; // Start of Morgan/Lewis
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1403,-86.806691)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140317,-86.806662)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140345,-86.806629)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140384,-86.806606)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140425,-86.806592)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140588,-86.806555)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14066,-86.806545)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140727,-86.806545)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140759,-86.806551)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140795,-86.806567)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140843,-86.806602)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140892,-86.806655)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140922,-86.806692)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14097,-86.806768)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141043,-86.80676)]; // End of Morgan/Lewis turn
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14231,-86.806587)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142725,-86.80653)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143422,-86.806438)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1437,-86.806396)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143954,-86.806357)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144042,-86.806343)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144163,-86.806328)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144214,-86.806329)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144258,-86.806338)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144302,-86.806361)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144874,-86.806777)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145217,-86.806064)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145478,-86.805525)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145542,-86.805437)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145791,-86.804902)];
        
        routeColor = [UIColor redColor];
    } else if ([routeName isEqualToString:@"Green"]) {
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144863,-86.806782)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145217,-86.806064)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145478,-86.805525)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145542,-86.805437)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145791,-86.804902)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146322,-86.805296)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146838,-86.805682)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147319,-86.806036)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147901,-86.806451)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148118,-86.806012)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148809,-86.804535)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149496,-86.803156)]; // West End connection
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149211,-86.802951)]; // Beginning of circle
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149193,-86.802979)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149162,-86.803008)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149117,-86.803019)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149087,-86.803011)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149058,-86.802993)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148898,-86.802873)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148652,-86.802683)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148257,-86.802407)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148221,-86.802354)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148206,-86.802289)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148206,-86.802258)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148212,-86.802223)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14822,-86.802206)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148239,-86.802179)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148258,-86.802162)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148291,-86.802147)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148346,-86.802133)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148414,-86.802163)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14876,-86.802435)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149141,-86.80272)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149186,-86.802764)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149212,-86.802806)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149222,-86.802854)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149222,-86.8029)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149211,-86.802951)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149496,-86.803156)]; // End of Kissam turn...West End connection
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150025,-86.802069)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150231,-86.801652)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150455,-86.801198)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14951,-86.800505)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14972,-86.800055)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149781,-86.799943)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150007,-86.799485)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149781,-86.799943)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14972,-86.800055)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14951,-86.800505)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148934,-86.800063)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148838,-86.799997)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148489,-86.79974)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148323,-86.799612)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148033,-86.799443)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147951,-86.799404)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147798,-86.799362)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147579,-86.799316)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147335,-86.799356)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.147072,-86.799395)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146604,-86.799469)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146438,-86.799494)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.146062,-86.799548)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145604,-86.799618)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14506,-86.799698)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144821,-86.799736)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14454,-86.799778)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144381,-86.799802)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144081,-86.799844)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14407,-86.799752)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144049,-86.799549)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144018,-86.799236)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143948,-86.79849)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143902,-86.797975)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143869,-86.797606)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143814,-86.797054)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143756,-86.796501)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143682,-86.795851)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143663,-86.795684)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143102,-86.795796)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142663,-86.795877)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142313,-86.795943)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141764,-86.79605)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141033,-86.79619)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140354,-86.796319)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140091,-86.796371)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139672,-86.796453)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139064,-86.796568)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.13914,-86.797159)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139117,-86.79721)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.13908,-86.797231)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138969,-86.797259)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138641,-86.797306)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138563,-86.797335)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138524,-86.797385)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138514,-86.797471)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138563,-86.797919)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137312,-86.798142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137377,-86.798789)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137425,-86.799238)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137474,-86.799695)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137534,-86.800314)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137582,-86.800759)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137648,-86.801297)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137705,-86.801829)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137734,-86.802282)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1378,-86.802874)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137834,-86.803186)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137952,-86.804316)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138027,-86.805051)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138344,-86.805021)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138397,-86.805017)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138696,-86.805007)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138819,-86.805024)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139063,-86.805068)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139021,-86.80539)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139029,-86.805561)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139086,-86.806074)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139148,-86.806667)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139181,-86.807015)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139178,-86.807014)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139673,-86.806946)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140041,-86.8069)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140246,-86.806871)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1403,-86.806691)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140317,-86.806662)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140345,-86.806629)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140384,-86.806606)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140425,-86.806592)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140588,-86.806555)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14066,-86.806545)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140727,-86.806545)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140759,-86.806551)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140795,-86.806567)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140843,-86.806602)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140892,-86.806655)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140922,-86.806692)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140971,-86.806768)]; // End of turn
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141526,-86.80669)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141763,-86.80666)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142112,-86.806614)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142311,-86.806585)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142641,-86.806543)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142725,-86.806531)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142757,-86.806889)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142794,-86.807298)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142833,-86.807733)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142858,-86.80801)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142903,-86.808472)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143023,-86.809673)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143067,-86.810109)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143249,-86.81041)]; // Corner of Vanderbilt PL and 28th
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143145,-86.810601)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143248,-86.81041)]; // Start of Police Department loop
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143854,-86.810874)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143755,-86.811057)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143291,-86.8107)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143144,-86.810601)]; // End of Police Department loop (corner of Vanderbilt PL and 28th)
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143145,-86.810601)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142847,-86.81121)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142809,-86.811296)]; // Start of Blakemore House loop
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14294,-86.811399)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142951,-86.811427)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142951,-86.811444)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142797,-86.811781)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14278,-86.811789)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142748,-86.811773)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142621,-86.81169)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142809,-86.811296)]; // End of Blakemore House loop
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142847,-86.81121)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143145,-86.810601)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143249,-86.81041)]; // Corner of Vanderbilt PL and 28th
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143067,-86.810109)]; // Corner of Natchez and 28th
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144527,-86.809815)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144774,-86.809777)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144947,-86.809785)]; // Natchez and 26th
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144959,-86.809581)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144983,-86.809249)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145037,-86.809096)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145129,-86.808867)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145285,-86.808663)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145481,-86.808407)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145764,-86.807838)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145906,-86.807551)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145545,-86.807281)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145403,-86.807173)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.145346,-86.807124)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144863,-86.806782)];
        
        routeColor = [UIColor greenColor];
    }
    
    routePolyline = [GMSPolyline polylineWithPath:routePath];
    routePolyline.strokeColor = routeColor;
    routePolyline.strokeWidth = 3.0f;
    
    return routePolyline;
}

+ (NSInteger)routeIDForRouteName:(NSString *)routeName {
    NSInteger routeID;
    
    if ([routeName isEqualToString:@"Blue"]) {
        routeID = 745;
    } else if ([routeName isEqualToString:@"Green"]) {
        routeID = 749;
    } else { // Red
        routeID = 746;
    }
    
    return routeID;
}

@end