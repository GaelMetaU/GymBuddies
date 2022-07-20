//
//  GoogleMapsTableViewCell.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/20/22.
//

#import "GoogleMapsTableViewCell.h"

@implementation GoogleMapsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)setCellContent{
    self.map.settings.compassButton = YES;
    [self.map setMyLocationEnabled:YES];
    self.map.settings.myLocationButton = YES;
}


@end
