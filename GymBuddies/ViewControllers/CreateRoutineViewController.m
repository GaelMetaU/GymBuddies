//
//  CreateRoutineViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import "CreateRoutineViewController.h"
#import "ParseAPIManager.h"
#import "CommonValidations.h"
#import "SegmentedControlBlocksValues.h"
#import "AlertCreator.h"
#import "BodyZoneCollectionViewCell.h"
#import "AddExerciseViewController.h"
#import "ExerciseInCreateRoutineTableViewCell.h"
#import "ExerciseInRoutine.h"

@interface CreateRoutineViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, AddExerciseViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *exerciseList;
@property (nonatomic, strong) NSMutableArray *bodyZoneList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *titleField;
@property (weak, nonatomic) IBOutlet UITextView *captionField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *trainingLevelSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *workoutPlaceSegmentedControl;
@property (strong, nonatomic) Routine *routine;
@end

@implementation CreateRoutineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.exerciseList = [[NSMutableArray alloc]init];
    self.bodyZoneList = [[NSMutableArray alloc]init];
    self.routine = [Routine new];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}


#pragma mark - Posting

- (IBAction)didTapDone:(id)sender {
    
    [self _collectDataSources];
    
    [self _collectUserInputFields];
    
    [ParseAPIManager postRoutine:self.routine completion:^(BOOL succeeded, NSError * _Nonnull error) {
        if(!succeeded){
            UIAlertController *alert = [AlertCreator createOkAlert:@"Error saving routine" message:error.localizedDescription];
            [self presentViewController:alert animated:YES completion:nil];
        } else{
            [self _resetScreen];
        }
    }];
}

// Retrieves and standarizes all user input fields and adds them to the routine object
-(void)_collectUserInputFields{
    NSString *title = [CommonValidations standardizeUserAuthInput:self.titleField.text];
    NSString *caption = [CommonValidations standardizeUserAuthInput:self.captionField.text];
    if(title.length == 0){
        title = [NSString stringWithFormat:@"%@'s Routine", [PFUser currentUser].username];
    }
    
    TrainingLevels trainingLevel = [self.trainingLevelSegmentedControl selectedSegmentIndex];
    WorkoutPlace workoutPlace = [self.workoutPlaceSegmentedControl selectedSegmentIndex];
    
    self.routine.title = title;
    self.routine.caption = caption;
    self.routine.trainingLevel = [NSNumber numberWithLong:trainingLevel];
    self.routine.workoutPlace = [NSNumber numberWithLong:workoutPlace];
}

// Retrieves the data sources and user to add the to the routine object
-(void)_collectDataSources{
    NSMutableArray *exercisesToUpload = [[NSMutableArray alloc]init];
    for(ExerciseInCreateRoutineTableViewCell *cell in self.tableView.visibleCells){
        if([cell.reuseIdentifier isEqualToString: @"ExerciseInCreateRoutineTableViewCell"]){
            [exercisesToUpload addObject:cell.exerciseInRoutine];
        }
    }
    self.routine.exerciseList = exercisesToUpload;
    self.routine.bodyZoneList = self.bodyZoneList;
    self.routine.author = [PFUser currentUser];
}

// Clears off all fields after completing a post
-(void)_resetScreen{
    self.titleField.text = @"";
    self.captionField.text = @"";
    
    self.trainingLevelSegmentedControl.selectedSegmentIndex = TrainingLevelBeginner;
    self.workoutPlaceSegmentedControl.selectedSegmentIndex = WorkoutPlaceHome;

    [self.exerciseList removeAllObjects];
    [self.bodyZoneList removeAllObjects];
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
}


#pragma mark - Collection view methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bodyZoneList.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BodyZoneCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"BodyZoneCollectionViewCell" forIndexPath:indexPath];
    BodyZone *bodyZone = self.bodyZoneList[indexPath.item];
    [cell setCellContent:bodyZone];
    return cell;
}


#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.exerciseList.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1){
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AddExerciseTableViewCell"];
        return cell;
    } else{
        ExerciseInCreateRoutineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExerciseInCreateRoutineTableViewCell"];
        [cell setCellContent:self.exerciseList[indexPath.row]];
        return cell;
    }
}

// Allows user to delete an exercise from the table view by swiping left
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.exerciseList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self updateBodyZones];
    }
}


#pragma mark - AddExercise methods

- (void) didAddExercise:(Exercise *)exercise{
    ExerciseInRoutine *exerciseInRoutine = [ExerciseInRoutine initWithExercise:exercise];
    [self.exerciseList addObject:exerciseInRoutine];
    [self.tableView reloadData];
    
    if(![self isInBodyZoneList:exercise.bodyZoneTag]){
        [self.bodyZoneList addObject:exercise.bodyZoneTag];
        [self.collectionView reloadData];
    }
}


-(BOOL) isInBodyZoneList:(BodyZone *)newBodyZone{
    for(BodyZone *bodyZone in self.bodyZoneList){
        if([bodyZone.title isEqualToString:newBodyZone.title]){
            return true;
        }
    }
    return false;
}


-(void) updateBodyZones{
    [self.bodyZoneList removeAllObjects];
    for(ExerciseInRoutine *exerciseInRoutine in self.exerciseList){
        if(![self isInBodyZoneList:exerciseInRoutine.baseExercise.bodyZoneTag]){
            [self.bodyZoneList addObject:exerciseInRoutine.baseExercise.bodyZoneTag];
        }
    }
    [self.collectionView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BOOL isCreateExerciseSegue = [segue.identifier isEqualToString:@"AddExerciseSegue"];
    if(isCreateExerciseSegue){
        AddExerciseViewController *addExerciseViewController = [segue destinationViewController];
        addExerciseViewController.delegate = self;
    }
}

@end
