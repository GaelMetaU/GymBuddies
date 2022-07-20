//
//  BodyZone.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface BodyZone : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) PFFileObject *icon;
@end

NS_ASSUME_NONNULL_END
