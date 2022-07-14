//
//  AddExerciseTableViewCell.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/14/22.
//

#import "AddExerciseTableViewCell.h"

@implementation AddExerciseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setExercise:(Exercise *)exercise{
    self.exerciseImage.file = exercise.image;
    self.bodyZoneIcon.file = exercise.bodyZoneTag.icon;
    
    [self.exerciseImage loadInBackground];
    [self.bodyZoneIcon loadInBackground];
    
    self.titleLabel.text = exercise.title;
    self.captionLabel.text = exercise.caption;
    
}

@end
