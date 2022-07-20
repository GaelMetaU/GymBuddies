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

@interface GoogleMapsTableViewCell : UITableViewCell <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet GMSMapView *map;
@property (strong, nonatomic) CLLocationManager *manager;
-(void)setCellContent;
@end

NS_ASSUME_NONNULL_END
