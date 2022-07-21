//
//  GoogleMapsTableViewCell.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/20/22.
//

#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"
#import "CoreLocation/CoreLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoogleMapsView : UIView <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet GMSMapView *map;
@property (weak, nonatomic) IBOutlet UISegmentedControl *placesSegmentedControl;
@property (strong, nonatomic) CLLocationManager *manager;
@property CLLocationCoordinate2D currentLocation;
@property (strong, nonatomic) NSMutableArray *parksList;
@property (strong, nonatomic) NSMutableArray *gymsList;
@property (strong, nonatomic) NSMutableArray *markers;
-(void)setCellContent;
@end

NS_ASSUME_NONNULL_END
