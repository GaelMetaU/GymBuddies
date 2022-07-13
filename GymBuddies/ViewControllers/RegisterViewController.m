//
//  RegisterViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import "RegisterViewController.h"
#import "ParseAPIManager.h"
#import "DataModelBlocks.h"
#import "CommonValidations.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *skillLevelControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *workoutPlaceControl;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Buttons interactions

- (IBAction)didTapSubmit:(id)sender {
    
    NSString *email = [CommonValidations standardizeUserAuthInput:self.emailField.text];
    NSString *username = [CommonValidations standardizeUserAuthInput:self.usernameField.text];
    NSString *password = [CommonValidations standardizeUserAuthInput:self.passwordField.text];
    NSString *confirmPassword = [CommonValidations standardizeUserAuthInput:self.confirmPasswordField.text];
    
    if([self _lookForEmptyFields:username email:email password:password confirmPassword:confirmPassword]){
        [self _emptyFieldAlert];
        return;
    }
    
    if(![self _checkPasswordsMatching]){
        [self _passwordsNotMatchingAlert];
        return;
    }
    
    TrainingLevels level = [self.skillLevelControl selectedSegmentIndex];
    
    WorkoutPlace place = [self.workoutPlaceControl selectedSegmentIndex];
    
    PFUser *user = [[PFUser alloc]init];
    user[@"email"] = email;
    user[@"username"] = username;
    user[@"password"] = password;
    user[@"skillLevel"] = [NSNumber numberWithLong:level];
    user[@"workoutPlace"] = [NSNumber numberWithLong:place];
    
    [ParseAPIManager signUp:user completion:^(BOOL succeeded, NSError * _Nonnull error) {
        if(error != nil){
            [self _submitErrorAlert:[error localizedDescription]];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

#pragma mark - Validations

    
- (BOOL)_lookForEmptyFields:(NSString *)username
                      email:(NSString *)email
                   password:(NSString *)password
            confirmPassword:(NSString *)confirmPassword {
    
    return (username.length == 0 || password.length == 0 || confirmPassword == 0 || email.length == 0);

}


-(BOOL)_checkPasswordsMatching{
    NSString *password = self.passwordField.text;
    NSString *confirmPassword = self.confirmPasswordField.text;
    
    return [password isEqualToString:confirmPassword];
}


#pragma mark - Alerts

-(void)_emptyFieldAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty field" message:@"There is one or more empty fields" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)_passwordsNotMatchingAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Password matching" message:@"Make sure both passwords you provide are the same" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)_submitErrorAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Submit error" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
