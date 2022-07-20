//
//  SavedExercise.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/14/22.
//

#import <Parse/Parse.h>
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface SavedExercise : PFObject<PFSubclassing>
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) Exercise *exercise;
@end

NS_ASSUME_NONNULL_END
