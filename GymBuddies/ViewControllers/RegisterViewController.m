//
//  RegisterViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/7/22.
//

#import "RegisterViewController.h"
#import "ParseManager.h"

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

- (IBAction)updateSkillLevel:(id)sender {
    NSString *levels[]= {@"BEGINNER",@"INTERMEDIATE",@"EXPERT"};
    self.skillLevel = levels[[self.skillLevelControl selectedSegmentIndex]];
}


- (IBAction)updateWorkoutPlace:(id)sender {
    NSString *places[]= {@"HOME",@"PARK",@"GYM"};
    self.workoutPlace = places[[self.skillLevelControl selectedSegmentIndex]];
}



- (IBAction)didTapSubmit:(id)sender {
    NSString *email = self.emailField.text;
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    PFUser *user = [[PFUser alloc]init];
    user[@"email"] = email;
    user[@"username"] = username;
    user[@"password"] = password;
    user[@"skillLevel"] = self.skillLevel;
    user[@"workoutPlace"] = self.workoutPlace;
    
}

#pragma mark - Validations




@end
