//
//  GoogleMapsTableViewCell.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/20/22.
//

#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoogleMapsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet GMSMapView *map;
-(void)setCellContent;
@end

NS_ASSUME_NONNULL_END
