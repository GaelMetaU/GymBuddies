//
//  CreateRoutineViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import "CreateRoutineViewController.h"
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

@end

@implementation CreateRoutineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.exerciseList = [[NSMutableArray alloc]init];
    self.bodyZoneList = [[NSMutableArray alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // Do any additional setup after loading the view.
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
    return self.exerciseList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExerciseInCreateRoutineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExerciseInCreateRoutineTableViewCell"];
    [cell setCellContent:self.exerciseList[indexPath.row]];
    return cell;
}


#pragma mark - AddExercise delegate method

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BOOL isCreateExerciseSegue = [segue.identifier isEqualToString:@"AddExerciseSegue"];
    if(isCreateExerciseSegue){
        AddExerciseViewController *addExerciseViewController = [segue destinationViewController];
        addExerciseViewController.delegate = self;
    }
}

@end
