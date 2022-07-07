//
//  ParseManager.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import "ParseManager.h"

@implementation ParseManager

+(void)logIn:(NSString *)username password:(NSString *)password completion:(void (^)(PFUser * _Nonnull, NSError * _Nonnull))completion{
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        completion(user, error);
    }];
}

+ (void)signUp:(PFUser *)user{
    
}

@end
