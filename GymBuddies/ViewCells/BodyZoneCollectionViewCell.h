//
//  BodyZoneCollectionViewCell.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BodyZoneCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
