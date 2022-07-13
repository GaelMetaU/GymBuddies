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

+ (void)saveExercise:(Exercise *)exercise completion:(ParseManagerCreateCompletionBlock) completion{
    
    Exercise *newExercise = [Exercise new];
    newExercise.title = exercise.title;
    newExercise.image = exercise.image;
    newExercise.caption = exercise.caption;
    newExercise.author = exercise.author;
    newExercise.video = exercise.video;
    newExercise.bodyZoneTag = exercise.bodyZoneTag;
    
    ParseManagerCreateCompletionBlock block = ^void(BOOL succeeded, NSError * _Nullable error){
        completion(succeeded, error);
    };
    
    [newExercise saveInBackgroundWithBlock:block];

}


@end
