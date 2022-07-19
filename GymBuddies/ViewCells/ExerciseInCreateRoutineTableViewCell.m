//
//  ExerciseInCreateRoutineTableViewCell.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/18/22.
//

#import "ExerciseInCreateRoutineTableViewCell.h"

@implementation ExerciseInCreateRoutineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCellContent:(ExerciseInRoutine *)exerciseInRoutine{
    _exerciseInRoutine = exerciseInRoutine;
    
    self.exerciseImage.file = self.exerciseInRoutine.baseExercise.image;
    [self.exerciseImage loadInBackground];
    self.bodyZoneIcon.file = self.exerciseInRoutine.baseExercise.bodyZoneTag.icon;
    [self.bodyZoneIcon loadInBackground];
    self.exerciseTitle.text = self.exerciseInRoutine.baseExercise.title;
    
    UIAction *reps = [UIAction actionWithTitle:@"reps" image:nil identifier:nil handler:^(UIAction *action){
        NSLog(@"reps");
    }];
    
    UIAction *sec = [UIAction actionWithTitle:@"sec" image:nil identifier:nil handler:^(UIAction *action){
        NSLog(@"sec");
    }];
    
    UIAction *min = [UIAction actionWithTitle:@"min" image:nil identifier:nil handler:^(UIAction *action){
        NSLog(@"min");
    }];
    
    UIMenu *menu = [[UIMenu alloc]menuByReplacingChildren:[NSArray arrayWithObjects:reps, sec, min, nil]];
    self.amountUnitDropdownMenu.menu = menu;
    self.amountUnitDropdownMenu.showsMenuAsPrimaryAction = YES;
}



@end
