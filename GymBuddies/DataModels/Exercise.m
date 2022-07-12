//
//  Exercise.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/11/22.
//

#import "Exercise.h"

@implementation Exercise

@dynamic title;
@dynamic caption;
@dynamic image;
@dynamic video;
@dynamic author;
@dynamic bodyZoneTag;

+ (nonnull NSString *)parseClassName {
    return @"Exercise";
}

+ (PFFileObject *)getPFFileFromURL:(NSURL *)video{
    if(!video){
        return nil;
    }
    NSData *videoData = [NSData dataWithContentsOfURL:video];
    // get image data and check if that is not nil
    if (!videoData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"video.mov" data:videoData];
}


+ (PFFileObject *)getPFFileFromImage:(UIImage *)image{
    if(!image){
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}




@end
