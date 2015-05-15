//
//  TXLiabrayOptionManager.h
//  appDoctor
//
//  Created by senwang on 14/11/14.
//  Copyright (c) 2014年 senwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WSCameraAndAlbum : NSObject
typedef void (^ImagePickerSelected)(UIViewController *fromViewController, NSArray *selectedImageDatas);
typedef void (^ImagePickerCancled)(UIViewController *fromViewController);


+ (void)showSelectPicsWithController:(UIViewController *)fromViewController multipleChoice:(BOOL)mutible selectDidDo:(ImagePickerSelected)selectDidDo cancleDidDo:(ImagePickerCancled)cancleDidDo;

@end
