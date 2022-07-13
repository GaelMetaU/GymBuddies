//
//  ParseManager.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ParseManagerAuthenticationCompletionBlock) (PFUser *user, NSError *error);
typedef void (^ParseManagerCreateCompletionBlock) (BOOL succeded, NSError *error);
typedef void (^ParseManagerLogOutCompletionBlock) (NSError * _Nullable errorAPI);
typedef void (^ParseManagerFetchingDataRowsCompletionBlock) (NSArray *elements, NSError *error);


@interface ParseAPIManager : NSObject
+(void)logIn:(NSString *)username
    password:(NSString *)password
  completion:(ParseManagerAuthenticationCompletionBlock) completion;

+(void)signUp:(PFUser *)user
   completion:(ParseManagerCreateCompletionBlock) completion;

+(void)logOut:(ParseManagerLogOutCompletionBlock) completion;

+(void)fetchBodyZones:(ParseManagerFetchingDataRowsCompletionBlock) completion;

+ (PFFileObject *)getPFFileFromURL:(NSURL *)video;

+ (PFFileObject *)getPFFileFromImage:(UIImage *)image;

//+ (void)saveExercise:(Exercise *)exercise completion:(void(^)(BOOL succeeded, NSError * _Nullable error)) completion;

@end

NS_ASSUME_NONNULL_END
