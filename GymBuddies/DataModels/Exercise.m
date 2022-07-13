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



@end
