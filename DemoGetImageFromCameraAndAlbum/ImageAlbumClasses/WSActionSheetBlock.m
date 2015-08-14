//
//  ZMActionSheetBlock.m
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-9.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import "WSActionSheetBlock.h"
#import "ELCImagePickerHeader.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/ALAsset.h>
@interface WSActionSheetBlock()<UIActionSheetDelegate,ELCImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation WSActionSheetBlock

- (void)dealloc
{
    NSLog(@"ZMActionSheetBlock delloc");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)showInView:(UIView *)view multipleChoice:(BOOL)multiple
       selectDidDo:(ImagePickerSelected)selectDidDo
       cancleDidDo:(ImagePickerCancled)cancleDidDo
{
    self.delegate = self;
    self.selectDidDo = selectDidDo;
    self.cancleDidDo = cancleDidDo;
    self.multipleChoice = multiple;
    
    if (view) {
        [self showInView:view];
    } else {
        //show keyWindow
        [self showInView:[UIApplication sharedApplication].keyWindow];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(WSActionSheetBlock *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        if (actionSheet.cancleDidDo) {
            [actionSheet cancleDidDo];
        }
    } else {
        if (buttonIndex == 0) {
            if (self.multipleChoice) {
                ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
                elcPicker.maximumImagesCount = 100; //Set the maximum number of images to select to 100
                elcPicker.returnsOriginalImage = NO; // if NO,Only return the fullScreenImage, not the fullResolutionImage
                elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
                elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
                elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types@[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
                elcPicker.imagePickerDelegate = self;
                [self.fromViewController presentViewController:elcPicker animated:YES completion:nil];
            }else
            {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerController.delegate= self;
                [self.fromViewController presentViewController:imagePickerController animated:YES completion:nil];
            }
        }
        else if (buttonIndex == 1){
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.delegate= self;
            [self.fromViewController presentViewController:imagePickerController animated:YES completion:nil];
        }
        
        if (actionSheet.selectDidDo) {
            [actionSheet selectDidDo];
        }
    }
}

- (void)actionSheetCancel:(WSActionSheetBlock *)actionSheet
{
    if (actionSheet.cancleDidDo) {
        [actionSheet cancleDidDo];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self.fromViewController dismissViewControllerAnimated:YES completion:nil];

    
    NSMutableArray *imagesData = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                NSData *data;
                if (UIImagePNGRepresentation(image))
                {
                    data = UIImagePNGRepresentation(image);
                    data = UIImageJPEGRepresentation(image, 0.0f);
                }
                else
                {
                    data = UIImageJPEGRepresentation(image, 0.0f);
                }
                
                [imagesData addObject:data];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                NSData *data = UIImageJPEGRepresentation(image, 0);
                [imagesData addObject:data];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    if (_selectDidDo) {
        _selectDidDo(_fromViewController,imagesData);
    }

}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self.fromViewController dismissViewControllerAnimated:YES completion:nil];
    if (_cancleDidDo) {
        _cancleDidDo(_fromViewController);
    }
}

#pragma mark - 拍照代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_selectDidDo) {
            _selectDidDo(_fromViewController,[NSArray arrayWithObjects:UIImageJPEGRepresentation(originalImage, 0), nil]);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        if (_cancleDidDo) {
            _cancleDidDo(_fromViewController);
        }
    }];
}
@end
