//
//  MapViewController.m
//  ContactList
//
//  Created by Hanson Jung on 2017. 3. 7..
//  Copyright © 2017년 waaoo. All rights reserved.
//

#import "MapViewController.h"
// MapKit, CoreLocation 프레임워크 상속받고
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"



static const CGFloat BASE_LATITUDE = 37.563214; // 위도
static const CGFloat BASE_LONGITUDE = 127.006686; // 경도

@interface MapViewController () <CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CGFloat customLatitude;
@property (nonatomic) CGFloat customLongitude;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(BASE_LATITUDE, BASE_LONGITUDE);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.0005, 0.0005); // 1 = 111 kilometers
    
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region];
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    [self.mapView setShowsUserLocation:YES];
    
    
    
    // longPress Gesture
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPress:)];
    longPressGesture.minimumPressDuration = 1.0;
    [self.mapView addGestureRecognizer:longPressGesture];
    
    
   
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocationCoordinate2D coordinate = ((CLLocation *)locations.lastObject).coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region];
    
    [manager stopUpdatingLocation];
    
//    Annotation *anno = [[Annotation alloc] initWithTitle:@"myPosition" AndCoordinate:coordinate];
//    [self.mapView addAnnotation:anno];
    
    
}

- (void)mapLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        CGPoint touchLocation = [gestureRecognizer locationInView:self.mapView];
        
        CLLocationCoordinate2D coordinate;
        coordinate = [self.mapView convertPoint:touchLocation toCoordinateFromView:self.mapView];// how to convert this to a String or something else?
        
        _customLatitude = coordinate.latitude;
        _customLongitude = coordinate.longitude;
        CLLocationCoordinate2D customCoordinate = CLLocationCoordinate2DMake(_customLatitude, _customLongitude);
        
        Annotation *anno = [[Annotation alloc] initWithTitle:@"myPosition" AndCoordinate:customCoordinate];
        [self.mapView addAnnotation:anno];
        NSLog(@"Longpress");
        NSLog(@"LongPress coordinate: latitude = %f, longitude  = %f", coordinate.latitude, coordinate.longitude);
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
