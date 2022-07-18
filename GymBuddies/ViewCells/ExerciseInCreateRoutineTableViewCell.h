//
//  ExerciseInCreateRoutineTableViewCell.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/18/22.
//

#import <UIKit/UIKit.h>
#import "Parse/PFImageView.h"
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExerciseInCreateRoutineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *exerciseImage;
@property (weak, nonatomic) IBOutlet PFImageView *bodyZoneIcon;
@property (weak, nonatomic) IBOutlet UILabel *exerciseTitle;
@property (weak, nonatomic) IBOutlet UITextField *numberOfRepsOrTimeField;
@property (weak, nonatomic) IBOutlet UITextField *numberOfSets;
@property (strong, nonatomic) Exercise *exercise;
- (void) setCellContent:(Exercise *)exercise;
@end

NS_ASSUME_NONNULL_END
