//
//  ExerciseInRoutine.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/18/22.
//

#import "ExerciseInRoutine.h"

@implementation ExerciseInRoutine
@dynamic amount;
@dynamic amountUnit;
@dynamic numberOfSets;
@dynamic baseExercise;

+ (nonnull NSString *)parseClassName {
    return @"ExerciseInRoutine";
}

+(ExerciseInRoutine *) initWithExercise:(Exercise *)exercise{
    ExerciseInRoutine *exerciseInRoutine = [ExerciseInRoutine new];
    exerciseInRoutine.baseExercise = exercise;
    exerciseInRoutine.amount = @10;
    exerciseInRoutine.amountUnit = @2;
    exerciseInRoutine.numberOfSets = @4;
    
    return exerciseInRoutine;
}

@end
