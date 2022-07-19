//
//  Routine.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/19/22.
//

#import "Routine.h"

@implementation Routine
@dynamic placeTag;
@dynamic trainingLevel;
@dynamic saveCount;
@dynamic author;
@dynamic title;
@dynamic caption;
@dynamic exerciseList;

+ (nonnull NSString *)parseClassName {
    return @"Routine";
}


+(Routine *)initWithAttributes:(PFUser *)author
                  exerciseList:(NSMutableArray *)exerciseList
                         title:(NSString *)title
                       caption:(NSString *)caption
                 trainingLevel:(NSNumber *)trainingLevel
                      placeTag:(NSNumber *)placeTag{
    Routine *routine = [Routine new];
    routine.author = author;
    routine.exerciseList = exerciseList;
    routine.title = title;
    routine.caption = caption;
    routine.trainingLevel = trainingLevel;
    routine.placeTag = placeTag;
    routine.saveCount = @0;
    
    return routine;
}


@end
