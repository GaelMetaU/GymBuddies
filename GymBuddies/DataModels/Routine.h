//
//  Routine.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/19/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Routine : PFObject<PFSubclassing>
@property (nonatomic, strong) NSNumber *placeTag;
@property (nonatomic, strong) NSNumber *trainingLevel;
@property (nonatomic, strong) NSNumber *saveCount;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSMutableArray *exerciseList;
+(Routine *)initWithAttributes:(PFUser *)author
                  exerciseList:(NSMutableArray *)exerciseList
                         title:(NSString *)title
                       caption:(NSString *)caption
                 trainingLevel:(NSNumber *)trainingLevel
                      placeTag:(NSNumber *)placeTag;
@end

NS_ASSUME_NONNULL_END
