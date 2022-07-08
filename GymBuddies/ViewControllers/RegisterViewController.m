//
//  RegisterViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import "RegisterViewController.h"
#import "ParseAPIManager.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *skillLevelControl;
@property (strong, nonatomic) NSString *skillLevel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *workoutPlaceControl;
@property (strong, nonatomic) NSString *workoutPlace;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Buttons interactions

- (IBAction)didTapSubmit:(id)sender {
    
    if([self lookForEmptyFields]){
        [self emptyFieldAlert];
        return;
    }
    
    if(![self checkPasswordsMatching]){
        [self passwordsNotMatchingAlert];
        return;
    }
    
    NSString *levels[]= {@"BEGINNER",@"INTERMEDIATE",@"EXPERT"};
    self.skillLevel = levels[[self.skillLevelControl selectedSegmentIndex]];
    
    NSString *places[]= {@"HOME",@"PARK",@"GYM"};
    self.workoutPlace = places[[self.skillLevelControl selectedSegmentIndex]];
    
    NSString *email = self.emailField.text;
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    PFUser *user = [[PFUser alloc]init];
    user[@"email"] = email;
    user[@"username"] = username;
    user[@"password"] = password;
    user[@"skillLevel"] = self.skillLevel;
    user[@"workoutPlace"] = self.workoutPlace;
    
    [ParseAPIManager signUp:user completion:^(BOOL succeeded, NSError * _Nonnull error) {
        if(error != nil){
            [self submitErrorAlert:[error localizedDescription]];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

#pragma mark - Validations


- (BOOL)lookForEmptyFields{
    NSString *email = self.emailField.text;
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *confirmPassword = self.confirmPasswordField.text;
    
    if([username isEqualToString:@""] || [password isEqualToString:@""] || [confirmPassword isEqualToString:@""] || [email isEqualToString:@""]){
        return YES;
    } else {
        return NO;
    }
}


-(BOOL)checkPasswordsMatching{
    NSString *password = self.passwordField.text;
    NSString *confirmPassword = self.confirmPasswordField.text;
    
    if([password isEqualToString:confirmPassword]){
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - Alerts

-(void)emptyFieldAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty field" message:@"There is one or more empty fields" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)passwordsNotMatchingAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Password matching" message:@"Make sure both passwords you provide are the same" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)submitErrorAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Submit error" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
