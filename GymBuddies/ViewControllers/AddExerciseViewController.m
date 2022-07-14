//
//  AddExerciseViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import "AddExerciseViewController.h"
#import "ParseAPIManager.h"
#import "AddExerciseTableViewCell.h"
#import "SavedExercise.h"

@interface AddExerciseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *exercises;

@end

@implementation AddExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadUsersExercises];
}


#pragma mark - Data fetching

-(void)loadUsersExercises{
    [ParseAPIManager fetchUsersExercises:^(NSArray * _Nonnull elements, NSError * _Nonnull error) {
        if(elements!=nil){
            self.exercises = elements;
            [self.tableView reloadData];
        } else {
            [self _errorFetchingAlert:error.localizedDescription];
        }
    }];
    
    //[ParseAPIManager fetchUsersExercises:^(NSArray * _Nonnull elements, NSError * _Nonnull error) {}];
}


#pragma mark - Table view methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddExerciseTableViewCell"];
    [cell setExercise:self.exercises[indexPath.row][@"exercise"]];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.exercises.count;
}


#pragma mark - Alerts

-(void)_errorFetchingAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error fetching exercises" message:message preferredStyle:UIAlertControllerStyleAlert];

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
