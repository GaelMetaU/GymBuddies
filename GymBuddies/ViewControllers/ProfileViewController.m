//
//  ProfileViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/8/22.
//

#import "ProfileViewController.h"
#import "ParseAPIManager.h"
#import "SceneDelegate.h"
#import "AlertCreator.h"

@interface ProfileViewController ()
@end

@implementation ProfileViewController

- (IBAction)didTapLogOut:(id)sender {
    [ParseAPIManager logOut:^(NSError * _Nonnull error) {
        if(error){
            UIAlertController *alert = [AlertCreator createOkAlert:@"Error logging out" message:error.localizedDescription];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            SceneDelegate *delegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            delegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
