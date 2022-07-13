//
//  ParseManager.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import "ParseAPIManager.h"


@implementation ParseAPIManager

+(void)logIn:(NSString *)username
    password:(NSString *)password
  completion:(ParseManagerAuthenticationCompletionBlock)completion {

    ParseManagerAuthenticationCompletionBlock block = ^(PFUser *user, NSError *error) {completion(user,error);};
    
    [PFUser logInWithUsernameInBackground:username password:password block:block];
}


+ (void)signUp:(PFUser *)user
    completion:(ParseManagerRegisterCompletionBlock)completion{
    
    ParseManagerRegisterCompletionBlock block = ^(BOOL succeeded, NSError *error) {completion(succeeded, error);};
    
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

@end
