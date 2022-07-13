//
//  Exercise.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import <Parse/Parse.h>
#import "BodyZone.h"
#import "ParseAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface Exercise : PFObject<PFSubclassing>
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *video;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) BodyZone *bodyZoneTag;
+ (void)saveExercise:(Exercise *)exercise completion:(void(^)(BOOL succeeded, NSError * _Nullable error)) completion;

@end

NS_ASSUME_NONNULL_END
