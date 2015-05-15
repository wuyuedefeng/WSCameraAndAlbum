# WSCameraAndAlbum

##使用改库只需要一个函数即可搞定图片选取功能 包括单选多选拍照上传

![图片名称](http://gitcafe.com/image.png)

![图片名称](http://gitcafe.com/image.png)

![图片名称](http://gitcafe.com/image.png)

```objective-c
/**
*  选取图片或拍照功能
*
*  @param fromViewController  从哪个控制器跳出选取图片或调用相机
*  @param mutible    是否多选 YES多选  NO单选
*  @param selectDidDo   选择图片或照相点击确定执行的block 
*  @return cancleDidDo  选择图片或拍照点击取消后执行的操作
*/
+ (void)showSelectPicsWithController:(UIViewController *)fromViewController multipleChoice:(BOOL)mutible selectDidDo:(ImagePickerSelected)selectDidDo cancleDidDo:(ImagePickerCancled)cancleDidDo;

```

###实例代码

```objective-c
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


```