//
//  ViewController.m
//  DemoGetImageFromCameraAndAlbum
//
//  Created by TX-009 on 15/5/15.
//  Copyright (c) 2015年 TX-009. All rights reserved.
//

#import "ViewController.h"
#import "WSCameraAndAlbum.h"
@interface ViewController ()
@property (nonatomic,strong)UIButton *one;
@property (nonatomic,strong)UIButton *two;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *one = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 200, 100)];
    _one = one;
    [one setTitle:@"选择单张图片" forState:UIControlStateNormal];
    [one setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [one addTarget:self action:@selector(selectedOne:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:one];
    
    
    UIButton *two = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 200, 100)];
    _two = two;
    [two setTitle:@"选择多张图片" forState:UIControlStateNormal];
    [two setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [two addTarget:self action:@selector(selectedMany:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:two];
}

- (void)selectedOne:(UIButton *)btn
{
    [WSCameraAndAlbum showSelectPicsWithController:self multipleChoice:NO selectDidDo:^(UIViewController *fromViewController, NSArray *selectedImageDatas) {
        {
            if(selectedImageDatas.count > 0){
                ViewController *vc = (ViewController *)fromViewController;
                [vc.one setImage:[[UIImage alloc] initWithData:selectedImageDatas[0]] forState:UIControlStateNormal];
            }
        }
    } cancleDidDo:^(UIViewController *fromViewController) {
        NSLog(@"没有选择图片");
    }];
}


- (void)selectedMany:(UIButton *)btn
{
    [WSCameraAndAlbum showSelectPicsWithController:self multipleChoice:YES selectDidDo:^(UIViewController *fromViewController, NSArray *selectedImageDatas) {
        {
            if (selectedImageDatas.count > 0) {
                ViewController *vc = (ViewController *)fromViewController;
                [vc.two setImage:[[UIImage alloc] initWithData:selectedImageDatas[0]] forState:UIControlStateNormal];
            }
            NSLog(@"数组中共选择了%d张图片",(int)[selectedImageDatas count]);
        }
    } cancleDidDo:^(UIViewController *fromViewController) {
        NSLog(@"没有选择图片");
    }];
}
@end
