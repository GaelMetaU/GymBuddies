//
//  LoginViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "ParseAPIManager.h"
#import "SceneDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Button outlet actions


- (IBAction)didTapLogin:(id)sender {
    
    if(![self _lookForEmptyFields]){
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        
        [ParseAPIManager logIn:username password:password completion:^(PFUser * user, NSError *  error){
            if (error != nil) {
                [self _wrongCredentialsAlert:[error localizedDescription]];
            }
            else {
                SceneDelegate *delegate = (SceneDelegate *)self.view.window.windowScene.delegate;
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                delegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"AppTabController"];
            }
        }];
    }
    else {
        [self _emptyFieldAlert];
    }
}


#pragma mark - Alerts and validations

- (BOOL)_lookForEmptyFields{
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;

    return (username.length == 0 || password.length == 0);
}


-(void)_wrongCredentialsAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Wrong username or password" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];

    [self presentViewController:alert animated:YES completion:nil];
}


-(void)_emptyFieldAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty field" message:@"There is one or more empty fields" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
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
