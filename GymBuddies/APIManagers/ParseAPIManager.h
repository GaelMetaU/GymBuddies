//
//  ParseManager.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseAPIManager : NSObject
+(void)logIn:(NSString *)username password:(NSString *)password completion:(void(^)(PFUser *user, NSError *error)) completion;

+(void)signUp:(PFUser *)user completion:(void(^)(BOOL succeeded, NSError *error)) completion;

+(void)logOut:(void(^)(NSError *error)) completion;


@end

NS_ASSUME_NONNULL_END
