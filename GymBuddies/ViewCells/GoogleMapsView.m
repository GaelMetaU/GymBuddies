//
//  GoogleMapsTableViewCell.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/20/22.
//

#import "GoogleMapsView.h"

static NSString * const PLACE_TYPE_PARK = @"park";
static NSString * const PLACE_TYPE_GYM = @"gym";

@implementation GoogleMapsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)setCellContent{
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
        for(NSDictionary *gym in self.gymsList){
            CLLocationDegrees latitude = [gym[@"geometry"][@"location"][@"lat"] doubleValue];
            CLLocationDegrees longitude = [gym[@"geometry"][@"location"][@"lng"] doubleValue];

            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
            NSLog(@"%f , %f", position.latitude, position.longitude);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            marker.title = gym[@"name"];
            marker.map = self.map;
            [self.markers addObject:marker];
        }
    } else {
        for(NSDictionary *park in self.parksList){
            CLLocationDegrees latitude = [park[@"geometry"][@"location"][@"lat"] doubleValue];
            CLLocationDegrees longitude = [park[@"geometry"][@"location"][@"lng"] doubleValue];

            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longitude);
            NSLog(@"%f , %f", position.latitude, position.longitude);
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
    [self fetchPlacesNearby:PLACE_TYPE_GYM completion:^(NSMutableArray * data) {
        self.gymsList = data;
    }];
    [self fetchPlacesNearby:PLACE_TYPE_PARK completion:^(NSMutableArray * data) {
        self.parksList = data;
    }];
    
    [self placeMarkers:self.placesSegmentedControl.selectedSegmentIndex];
}



-(void)fetchPlacesNearby:(NSString *)placeType completion:(void(^)(NSMutableArray *))completion{
        
    // Retrieving Google API key
    NSString *path = [[NSBundle mainBundle] pathForResource:@"../Keys" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *googleAPIKey = [dict objectForKey:@"googleAPIKey"];
    //Creating request URL using the keys, location and type of place to search
    NSString *baseURL = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f%%2C%f&radius=1500&key=%@&type=%@", self.currentLocation.latitude, self.currentLocation.longitude, googleAPIKey, placeType];
    
    NSURL *URLRequest = [NSURL URLWithString:baseURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URLRequest
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:10.0];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *parkDataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        //self.parksList = [responseDictionary valueForKeyPath:@"results"];
                                                        return completion([responseDictionary valueForKeyPath:@"results"]);
                                                        
                                                    }
                                                }];
    [parkDataTask resume];
}


//-(void)fetchPlacesNearby{
//
//    // Retrieving Google API key
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"../Keys" ofType:@"plist"];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSString *googleAPIKey = [dict objectForKey:@"googleAPIKey"];
//    //Creating request URL using the keys, location and type of place to search
//    NSString *baseURL = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f%%2C%f&radius=1500&key=%@&type=", self.currentLocation.latitude, self.currentLocation.longitude, googleAPIKey];
//    NSString *parksURL = [baseURL stringByAppendingString:PLACE_TYPE_PARK];
//    NSString *gymsURL = [baseURL stringByAppendingString:PLACE_TYPE_GYM];
//
//    NSURL *parksURLRequest = [NSURL URLWithString:parksURL];
//    NSURL *gymsURLRequest = [NSURL URLWithString:gymsURL];
//
//
//    NSMutableURLRequest *parkRequest = [NSMutableURLRequest requestWithURL:parksURLRequest
//                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                           timeoutInterval:10.0];
//    NSMutableURLRequest *gymRequest = [NSMutableURLRequest requestWithURL:gymsURLRequest
//                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                           timeoutInterval:10.0];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDataTask *parkDataTask = [session dataTaskWithRequest:parkRequest
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                    if (error) {
//                                                        NSLog(@"%@", error);
//                                                    } else {
//                                                        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                                        self.parksList = [responseDictionary valueForKeyPath:@"results"];
//                                                        for(NSDictionary *place in self.parksList){
//                                                            NSLog(@"park %f", [place[@"geometry"][@"location"][@"lat"] doubleValue]);
//                                                        }
//                                                    }
//                                                }];
//    [parkDataTask resume];
//
//    NSURLSessionDataTask *gymDataTask = [session dataTaskWithRequest:gymRequest
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                    if (error) {
//                                                        NSLog(@"%@", error);
//                                                    } else {
//                                                        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                                        self.gymsList = [responseDictionary valueForKeyPath:@"results"];
//                                                        for(NSDictionary *place in self.gymsList){
//                                                            NSLog(@"gym %f", [place[@"geometry"][@"location"][@"lat"] doubleValue]);
//                                                        }
//                                                    }
//                                                }];
//    [gymDataTask resume];
//
//    while([parkDataTask state] != NSURLSessionTaskStateCompleted && [gymDataTask state] != NSURLSessionTaskStateCompleted){
//
//    }
//    NSLog(@"done");
//
//}

@end
