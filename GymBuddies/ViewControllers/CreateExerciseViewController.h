//
//  CreateExerciseViewController.h
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateExerciseViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) Exercise *exercise;
@end

NS_ASSUME_NONNULL_END
