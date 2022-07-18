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

- (void) setCellContent:(Exercise *)exercise{
    _exercise = exercise;
    
    self.exerciseImage.file = self.exercise.image;
    [self.exerciseImage loadInBackground];
    self.bodyZoneIcon.file = self.exercise.bodyZoneTag.icon;
    [self.bodyZoneIcon loadInBackground];
    self.exerciseTitle.text = self.exercise.title;
}

@end
