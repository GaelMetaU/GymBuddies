//
//  CreateExerciseViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import "CreateExerciseViewController.h"
#import "AVKit/AVKit.h"
#import "AVFoundation/AVFoundation.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"
#import "ParseAPIManager.h"
#import "BodyZoneCollectionViewCell.h"
#import "BodyZone.h"

@interface CreateExerciseViewController ()
@property (strong, nonatomic) UIImagePickerController *mediaPicker;
@property (weak, nonatomic) IBOutlet PFImageView *imagePreview;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *captionField;
@property (strong, nonatomic) NSArray *bodyZones;
@property (weak, nonatomic) IBOutlet UICollectionView *bodyZoneCollectionView;
@end

@implementation CreateExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Media picker set up
    self.mediaPicker = [UIImagePickerController new];
    self.mediaPicker.delegate = self;
    self.mediaPicker.allowsEditing = YES;
    // Collection view set up
    self.bodyZoneCollectionView.dataSource = self;
    self.bodyZoneCollectionView.delegate = self;
    [self fetchBodyZones];
    
}



#pragma mark -Collection View Data

-(void)fetchBodyZones{
    [ParseAPIManager fetchBodyZones:^(NSArray * _Nonnull elements, NSError * _Nonnull error) {
        if(elements == nil){
            [self _failedFetching:error.localizedDescription];
        } else {
            self.bodyZones = elements;
            [self.bodyZoneCollectionView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BodyZoneCollectionViewCell *cell = [self.bodyZoneCollectionView dequeueReusableCellWithReuseIdentifier:@"BodyZoneCollectionViewCell" forIndexPath:indexPath];
    BodyZone *bodyZone = self.bodyZones[indexPath.item];
    cell.iconView.file = bodyZone[@"icon"];
    [cell.iconView loadInBackground];
    cell.titleLabel.text = bodyZone[@"title"];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bodyZones.count;
}

#pragma mark -Uploading media


- (IBAction)uploadVideo:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        self.mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.mediaPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
        [self presentViewController:self.mediaPicker animated:YES completion:nil];
    }
}


- (IBAction)uploadImage:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        self.mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.mediaPicker.mediaTypes = @[(NSString*)kUTTypeImage];
        [self presentViewController:self.mediaPicker animated:YES completion:nil];
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString*)kUTTypeMovie] ||  [mediaType isEqualToString:(NSString*)kUTTypeAVIMovie] || [mediaType isEqualToString:(NSString*)kUTTypeVideo] || [mediaType isEqualToString:(NSString*)kUTTypeMPEG4]){
        NSURL *urlVideo = [info objectForKey:UIImagePickerControllerMediaURL];
        PFFileObject *video = [Exercise getPFFileFromURL:urlVideo];
        self.exercise.video = video;
    } else {
        self.imagePreview.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    /*self.imagePreview.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];*/
}



#pragma mark -Alerts

-(void)_failedFetching:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error fetching data" message:message preferredStyle:UIAlertControllerStyleAlert];
    
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
