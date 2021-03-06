//
//  Exercise.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import "Exercise.h"

@implementation Exercise

@dynamic title;
@dynamic caption;
@dynamic image;
@dynamic video;
@dynamic author;
@dynamic bodyZoneTag;

+ (nonnull NSString *)parseClassName {
    return @"Exercise";
}

+(Exercise *) initWithAttributes:(NSString *)exerciseTitle
                         caption:(NSString *)exerciseCaption
                          author:(PFUser *)exerciseAuthor
                           video:(PFFileObject *)exerciseVideo
                           image:(PFFileObject *)exerciseImage
                     bodyZoneTag:(BodyZone *)exerciseBodyZoneTag{
    Exercise *exercise = [Exercise new];
    exercise.title = exerciseTitle;
    exercise.image = exerciseImage;
    exercise.caption = exerciseCaption;
    exercise.author = exerciseAuthor;
    exercise.video = exerciseVideo;
    exercise.bodyZoneTag = exerciseBodyZoneTag;
    
    return exercise;
}

@end
