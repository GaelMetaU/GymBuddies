//
//  ParseManager.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ParseManagerAuthenticationCompletionBlock) (PFUser *user, NSError *error);
typedef void (^ParseManagerRegisterCompletionBlock) (BOOL succeded, NSError *error);
typedef void (^ParseManagerLogOutCompletionBlock) (NSError * _Nullable errorAPI);
typedef void (^ParseManagerFetchingDataRowsCompletionBlock) (NSArray *elements, NSError *error);


@interface ParseAPIManager : NSObject
+(void)logIn:(NSString *)username
    password:(NSString *)password
  completion:(ParseManagerAuthenticationCompletionBlock) completion;

+(void)signUp:(PFUser *)user
   completion:(ParseManagerRegisterCompletionBlock) completion;

+(void)logOut:(ParseManagerLogOutCompletionBlock) completion;


@end

NS_ASSUME_NONNULL_END
