//
//  VVRoute.m
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVRoute.h"

@implementation VVRoute

+ (NSArray *)markersForRouteName:(NSString *)routeName {
    NSMutableArray *mutableMarkers = [[NSMutableArray alloc] init];
    
    // Initialize Branscomb Quad stop.
    GMSMarker *branscombQuadMarker = [self createMarkerWithLatitude:36.1451786450032 longitude:-86.805682182312 andTitle:@"Branscomb Quad"];
    
    // Initialize Carmichael Towers stop.
    GMSMarker *carmichaelTowersMarker = [self createMarkerWithLatitude:36.1472839210716 longitude:-86.8059504032135 andTitle:@"Carmichael Towers"];
    
    // Initialize Murray House stop.
    GMSMarker *murrayHouseMarker = [self createMarkerWithLatitude:36.1399888548681 longitude:-86.7964553833008 andTitle:@"Murray House"];
    
    // Initialize Highland Quad stop.
    GMSMarker *highlandQuadMarker = [self createMarkerWithLatitude:36.1408206306468 longitude:-86.8065512180328 andTitle:@"Highland Quad"];
    
    [mutableMarkers addObject:branscombQuadMarker];
    [mutableMarkers addObject:carmichaelTowersMarker];
    [mutableMarkers addObject:murrayHouseMarker];
    [mutableMarkers addObject:highlandQuadMarker];
    
    if (![routeName isEqualToString:@"Red"]) {
        // Initialize Kissam Quad stop.
        GMSMarker *kissamQuadMarker = [self createMarkerWithLatitude:36.1490685964468 longitude:-86.8026459217072 andTitle:@"Kissam Quad"];
        
        [mutableMarkers addObject:kissamQuadMarker];
        
        if ([routeName isEqualToString:@"Green"]) {
            // Initialize Vanderbilt Police Station stop.
            GMSMarker *policeStationMarker = [self createMarkerWithLatitude:36.1433765531155 longitude:-86.8107461929321 andTitle:@"Vanderbilt Police Station"];
            
            // Initialize Vanderbilt Bookstore stop.
            GMSMarker *bookstoreMarker = [self createMarkerWithLatitude:36.1455078688563 longitude:-86.8083053827286 andTitle:@"Vanderbilt Bookstore"];
            
            // Initialize Terrace Place Garage stop.
            GMSMarker *terracePlaceGarageMarker = [self createMarkerWithLatitude:36.14995225563 longitude:-86.7994487285614 andTitle:@"Terrace Place Garage"];
            
            // Initialize Wesley Place Garage stop.
            GMSMarker *wesleyPlaceGarageMarker = [self createMarkerWithLatitude:36.1459973701886 longitude:-86.799556016922 andTitle:@"Wesley Place Garage"];
            
            // Initialize Blair School of Music stop.
            GMSMarker *blairSchoolOfMusicMarker = [self createMarkerWithLatitude:36.1389231292643 longitude:-86.805859208107 andTitle:@"Blair School of Music"];
            
            // Initialize McGugin Center stop.
            GMSMarker *mcguginCenterMarker = [self createMarkerWithLatitude:36.142900031513 longitude:-86.8079996109009 andTitle:@"McGugin Center"];
            
            // Initialize Blakemore House stop.
            GMSMarker *blakemoreHouseMarker = [self createMarkerWithLatitude:36.14276140650328 longitude:-86.81162595748901 andTitle:@"Blakemore House"];
            
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
        GMSMarker *northHouseMarker = [self createMarkerWithLatitude:36.1414357924771 longitude:-86.7998135089874 andTitle:@"North House"];
        
        [mutableMarkers addObject:northHouseMarker];
    }
    
    return [mutableMarkers copy];
}

+ (GMSMarker *)createMarkerWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude andTitle:(NSString *)title {
    GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(latitude, longitude)];
    marker.title = title;
    
    return marker;
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148809,-86.804537)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148959,-86.804239)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149192,-86.803772)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149356,-86.803443)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149501,-86.803142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149207,-86.802929)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149182,-86.802977)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149162,-86.802999)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14913,-86.803019)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149091,-86.803015)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149062,-86.803004)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148236,-86.802382)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148199,-86.802299)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148226,-86.802201)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148289,-86.802156)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148339,-86.802143)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149194,-86.802775)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149221,-86.802856)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149207,-86.802929)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149501,-86.803142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149878,-86.802366)];
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140236,-86.806873)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140313,-86.806676)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140342,-86.806637)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140385,-86.806618)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140563,-86.806585)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140793,-86.806586)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140841,-86.806608)];
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14408,-86.799846)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143638,-86.799917)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143159,-86.799994)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142786,-86.800056)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142772,-86.799761)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142764,-86.799732)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142745,-86.7997)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142718,-86.799669)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142692,-86.799657)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142656,-86.799659)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141504,-86.799803)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141485,-86.799819)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141468,-86.79984)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141463,-86.79987)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141465,-86.799923)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141505,-86.800242)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140704,-86.800351)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140142,-86.800416)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139595,-86.800479)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138839,-86.800581)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137744,-86.800736)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137583,-86.800761)]; // Corner of 21st and Wedgewood
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137555,-86.800501)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137489,-86.799845)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137392,-86.798914)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137313,-86.798155)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137872,-86.798046)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138239,-86.797974)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138563,-86.797919)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138516,-86.797475)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138525,-86.797389)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138561,-86.797337)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138602,-86.797316)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138645,-86.797304)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.138966,-86.797259)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139074,-86.797236)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139118,-86.79721)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139144,-86.797167)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139065,-86.796568)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139672,-86.796451)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.1399888548681,-86.7964553833008)]; // Murray stop
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139672,-86.796451)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139065,-86.796568)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139144,-86.797167)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.139118,-86.797210)];
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.137583,-86.800761)]; // Back to corner of 21st and Wedgewood
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140311,-86.806679)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140344,-86.80664)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14039,-86.806618)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140576,-86.806585)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140743,-86.80658)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140798,-86.806585)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140841,-86.806605)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141043,-86.80676)];
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
        /*[routePath addCoordinate:CLLocationCoordinate2DMake(36.145217,-86.806064)];
         [routePath addCoordinate:CLLocationCoordinate2DMake(36.145478,-86.805525)];
         [routePath addCoordinate:CLLocationCoordinate2DMake(36.145542,-86.805437)];
         [routePath addCoordinate:CLLocationCoordinate2DMake(36.145791,-86.804902)]; */
        
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148809,-86.804537)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148959,-86.804239)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149192,-86.803772)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149356,-86.803443)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149501,-86.803142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149207,-86.802929)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149182,-86.802977)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149162,-86.802999)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14913,-86.803019)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149091,-86.803015)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149062,-86.803004)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148236,-86.802382)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148199,-86.802299)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148226,-86.802201)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148289,-86.802156)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148339,-86.802143)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149194,-86.802775)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149221,-86.802856)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149207,-86.802929)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149501,-86.803142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148959,-86.804239)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149192,-86.803772)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149356,-86.803443)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149501,-86.803142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149207,-86.802929)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149182,-86.802977)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149162,-86.802999)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14913,-86.803019)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149091,-86.803015)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149062,-86.803004)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148236,-86.802382)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148199,-86.802299)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148226,-86.802201)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148289,-86.802156)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.148339,-86.802143)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149194,-86.802775)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149221,-86.802856)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149207,-86.802929)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149501,-86.803142)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149878,-86.802366)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150025,-86.802069)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150231,-86.801652)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150455,-86.801198)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149502,-86.800479)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.150004,-86.799459)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149502,-86.800479)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.149502, -86.800494)];
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140234,-86.806876)]; // Start of Morgan/Lewis turn
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140311,-86.806679)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140345,-86.80664)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140391,-86.806618)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140579,-86.806586)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140743,-86.806581)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140798,-86.806585)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.140841,-86.806604)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.141043,-86.80676)]; // End of turn
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
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143287,-86.810693)]; // Start of Police Department loop
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143705,-86.810998)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143736,-86.811013)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143761,-86.811014)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143773,-86.811006)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143854,-86.810872)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143249,-86.81041)]; // End of Police Department loop (corner of Vanderbilt PL and 28th)]
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143145,-86.810601)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142847,-86.81121)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142804,-86.811293)]; // Start of Blakemore House loop
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142934,-86.811396)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14295,-86.811446)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142947,-86.811477)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.14279,-86.811786)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142765,-86.811786)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142616,-86.811696)]; // End of Blakemore House loop
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142804,-86.811293)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.142847,-86.81121)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143145,-86.810601)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143249,-86.81041)]; // Corner of Vanderbilt PL and 28th
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.143067,-86.810109)]; // Corner of Natchez and 28th
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144527,-86.809815)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144774,-86.809777)];
        [routePath addCoordinate:CLLocationCoordinate2DMake(36.144949,-86.80981)]; // Natchez and 26th
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

@end