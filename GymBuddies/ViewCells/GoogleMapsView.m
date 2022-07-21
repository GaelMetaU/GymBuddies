//
//  GoogleMapsTableViewCell.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/20/22.
//

#import "GoogleMapsView.h"

static NSString * const PLACE_TYPE_PARK = @"park";
static NSString * const PLACE_TYPE_GYM = @"gym";

@implementation GoogleMapsView


-(void)setContent{
    self.manager = [CLLocationManager new];
    self.map.settings.compassButton = YES;
    [self.map setMyLocationEnabled:YES];
    self.map.settings.myLocationButton = YES;
    
    self.currentLocation = self.manager.location.coordinate;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude zoom:13.0];
    self.map.camera = camera;
    
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    [self.manager startUpdatingLocation];
    
    [self setPlacesArrays];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocationCoordinate2D location = [locations firstObject].coordinate;
    self.currentLocation = location;
}


-(void)placeMarkers:(BOOL)isGym{
    [self.map clear];
    [self.markers removeAllObjects];
    
    if(isGym){
        for(NSDictionary *gym in self.gymsDictionary){
            CLLocationDegrees latitude = [gym[@"geometry"][@"location"][@"lat"] doubleValue];
            CLLocationDegrees longitude = [gym[@"geometry"][@"location"][@"lng"] doubleValue];

            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = gym[@"name"];
            marker.map = self.map;
            [self.markers addObject:marker];
        }
    } else {
        for(NSDictionary *park in self.parksDictionary){
            CLLocationDegrees latitude = [park[@"geometry"][@"location"][@"lat"] doubleValue];
            CLLocationDegrees longitude = [park[@"geometry"][@"location"][@"lng"] doubleValue];

            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = park[@"name"];
            marker.map = self.map;
            [self.markers addObject:marker];
        }
    }
}


- (IBAction)updateMarkers:(id)sender {
    [self placeMarkers:self.placesSegmentedControl.selectedSegmentIndex];
}


-(void)setPlacesArrays{
    BOOL isGym = self.placesSegmentedControl.selectedSegmentIndex;

    //After fetching the places near the users, the markers are placed depending on the selected index of the segmented control
    [self fetchPlacesNearby:PLACE_TYPE_GYM completion:^(NSMutableArray * data) {
        self.gymsDictionary = data;
        [self placeMarkers:isGym];
    }];
    [self fetchPlacesNearby:PLACE_TYPE_PARK completion:^(NSMutableArray * data) {
        self.parksDictionary = data;
        [self placeMarkers:isGym];
    }];
}



-(void)fetchPlacesNearby:(NSString *)placeType completion:(void(^)(NSMutableArray *))completion{
        
    // Retrieving Google API key
    NSString *path = [[NSBundle mainBundle] pathForResource:@"../Keys" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *googleAPIKey = [dict objectForKey:@"googleAPIKey"];
    //Creating request URL using the keys, location and type of place to search
    NSString *baseURL = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f%%2C%f&radius=5000&key=%@&type=%@", self.currentLocation.latitude, self.currentLocation.longitude, googleAPIKey, placeType];
    
    NSURL *URLRequest = [NSURL URLWithString:baseURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URLRequest
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:10.0];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *parkDataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                    } else {
                                                        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        return completion([responseDictionary valueForKeyPath:@"results"]);
                                                    }
                                                }];
    [parkDataTask resume];
}

@end
