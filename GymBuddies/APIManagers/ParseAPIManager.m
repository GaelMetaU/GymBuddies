//
//  ParseManager.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import "ParseAPIManager.h"

static NSString * const SAVED_EXERCISE_CLASS = @"SavedExercise";
static NSString * const ROUTINE_CLASS = @"Routine";


@implementation ParseAPIManager

+(void)logIn:(NSString *)username
    password:(NSString *)password
  completion:(ParseManagerAuthenticationCompletionBlock)completion {

    ParseManagerAuthenticationCompletionBlock block = ^(PFUser *user, NSError *error) {completion(user,error);};
    
    [PFUser logInWithUsernameInBackground:username password:password block:block];
}


+ (void)signUp:(PFUser *)user
    completion:(ParseManagerCreateCompletionBlock)completion{
    
    ParseManagerCreateCompletionBlock block = ^(BOOL succeeded, NSError *error) {completion(succeeded, error);};
    
    [user signUpInBackgroundWithBlock:block];
}


+(void)logOut:(ParseManagerLogOutCompletionBlock) completion{
    
    ParseManagerLogOutCompletionBlock block = ^void(NSError *errorAPI) {
        if(errorAPI){
            completion(errorAPI);
        }
        else{
            completion(nil);
        }
    };
    
    [PFUser logOutInBackgroundWithBlock:block];
}


+(void)fetchBodyZones:(ParseManagerFetchingDataRowsCompletionBlock) completion{
    PFQuery *query = [PFQuery queryWithClassName:@"BodyZone"];
    
    ParseManagerFetchingDataRowsCompletionBlock block = ^void(NSArray *elements, NSError *error){
        completion(elements, error);
    };
    
    [query findObjectsInBackgroundWithBlock:block];
}


+ (Exercise *)createExercise:(Exercise *)exercise
           completion:(ParseManagerCreateCompletionBlock) completion {
    
    Exercise *newExercise = [Exercise initWithAttributes:exercise.title caption:exercise.caption author:exercise.author video:exercise.video image:exercise.image bodyZoneTag:exercise.bodyZoneTag];
    
    ParseManagerCreateCompletionBlock block = ^void(BOOL succeeded, NSError * _Nullable error){
        completion(succeeded, error);
        if(!succeeded){
            return;
        }
    };
    
    [newExercise saveInBackgroundWithBlock:block];

    [self saveExercise:newExercise completion:block];

    return newExercise;
}


+ (void)saveExercise:(Exercise *)exercise completion:(ParseManagerCreateCompletionBlock)completion{
    PFObject *savedExercise = [PFObject objectWithClassName:@"SavedExercise"];
    
    savedExercise[@"author"] = exercise.author;
    savedExercise[@"exercise"] = exercise;
    
    ParseManagerCreateCompletionBlock block = ^void(BOOL succeeded, NSError * _Nullable error){
        completion(succeeded, error);
        if(!succeeded){
            return;
        }
    };
    
    [savedExercise saveInBackgroundWithBlock:block];
}


+ (void)fetchUsersExercises:(ParseManagerFetchingDataRowsCompletionBlock) completion{
    PFQuery *query = [PFQuery queryWithClassName:SAVED_EXERCISE_CLASS];
    [query includeKeys:@[@"exercise", @"exercise.author", @"exercise.bodyZoneTag", @"exercise.image"]];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];

    ParseManagerFetchingDataRowsCompletionBlock block = ^void(NSArray *elements, NSError *error){
        completion(elements, error);
    };
    
    [query findObjectsInBackgroundWithBlock:block];
    
}


+ (void)fetchHomeTimelineRoutines:(ParseManagerFetchingDataRowsCompletionBlock) completion{
    PFQuery *query = [PFQuery queryWithClassName:ROUTINE_CLASS];
    
    ParseManagerFetchingDataRowsCompletionBlock block = ^void(NSArray *elements, NSError *error){
        completion(elements, error);
    };
    
    [query findObjectsInBackgroundWithBlock:block];
}


+ (PFFileObject *)getPFFileFromURL:(NSURL *)video{
    if(!video){
        return nil;
    }
    NSData *videoData = [NSData dataWithContentsOfURL:video];
    // get image data and check if that is not nil
    if (!videoData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"video.mov" data:videoData];
}


+ (PFFileObject *)getPFFileFromImage:(UIImage *)image{
    if(!image){
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
