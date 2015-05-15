//
//  ZMActionSheetBlock.h
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-9.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCameraAndAlbum.h"
@interface WSActionSheetBlock : UIActionSheet

@property (nonatomic, assign)ImagePickerSelected selectDidDo;
@property (nonatomic, assign)ImagePickerCancled cancleDidDo;

@property (nonatomic, assign)BOOL multipleChoice;

@property (nonatomic, strong)UIViewController *fromViewController;

- (void)showInView:(UIView *)view multipleChoice:(BOOL)multiple
   selectDidDo:(ImagePickerSelected)selectDidDo
     cancleDidDo:(ImagePickerCancled)cancleDidDo;

@end
