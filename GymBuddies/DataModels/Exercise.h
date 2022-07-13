//
//  Exercise.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import <Parse/Parse.h>
#import "BodyZone.h"

NS_ASSUME_NONNULL_BEGIN

@interface Exercise : PFObject
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *video;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) BodyZone *bodyZoneTag;
+ (PFFileObject *)getPFFileFromURL:(NSURL *)video;
+ (PFFileObject *)getPFFileFromImage:(UIImage *)image;
+ (void)saveExercise:(Exercise *)exercise{
    
}
@end

NS_ASSUME_NONNULL_END
