//
//  ViewController.m
//  3DTouch
//
//  Created by Jason on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "TouchedView.h"
#import "PeekViewController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) UILabel *label;

@end

@implementation ViewController
- (void)check3DTouch
{
    // 如果开启了3D touch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.tableView];
    }
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self check3DTouch];
//}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self check3DTouch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.hidden = YES;
    self.view.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
    // Do any additional setup after loading the view, typically from a nib.
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"Boundle identifier" localizedTitle:@"第二个标签" localizedSubtitle:@"subtitle" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite] userInfo:nil];
    UIApplicationShortcutItem * item2 = [[UIApplicationShortcutItem alloc]initWithType:@"Custom Icon" localizedTitle:@"第三个标签" localizedSubtitle:@"详细标题" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"R2"] userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[item,item2];
    
    /**
     *  如果3Dtouch可用，注册代理
     */
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.tableView];
        
        NSLog(@"3D Touch is available! Hurra!");
        
        // no need for our alternative anymore
        
    } else {
        
        NSLog(@"3D Touch is not available on this device. Sniff!");
        
        // handle a 3D Touch alternative (long gesture recognizer)
        
    }
    
    [self customSubViews];
    
    
    
    
    
    
    
}
- (void)customSubViews{
//    TouchedView * touchView = [[TouchedView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
//    touchView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:touchView];
    
    
//    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, self.view.frame.size.width - 20, 100)];
//    _label.userInteractionEnabled = YES;
//    _label.textAlignment = NSTextAlignmentCenter;
//    _label.backgroundColor = [UIColor yellowColor];
//    _label.font = [UIFont boldSystemFontOfSize:20];
//    _label.text = @"Peek && Pop";
//    [self.view addSubview:_label];
}
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    previewingContext.sourceRect = _label.frame;
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[PeekViewController class]])
    {
        return nil;
    }
    else
    {
//        PeekViewController *peekViewController = [[PeekViewController alloc] init];
////    peekViewController.view.frame = CGRectMake(0, 0, 320, 170);
//        peekViewController.preferredContentSize = CGSizeMake(0.0, 300);
////        CGRect rect = CGRectMake(_label.frame.origin.x - 10, _label.frame.origin.y - 10, _label.frame.size.width , _label.frame.size.height + 20);
//        CGRect rect = CGRectMake(20 , -10, SCREEN_WIDTH-60 , _label.frame.size.height + 10);
////        CGRect rect = CGRectInset(_label.frame, -10, -10);
//        previewingContext.sourceRect = rect;
        NSLog(@"X:%f, Y:%f",location.x,location.y);
//        return peekViewController;
        
        /** 转换坐标 */
        CGPoint p = [_tableView convertPoint:CGPointMake(location.x, location.y ) fromView:self.view];
        NSLog(@"PPPPPX:%f, PPPPPY:%f",p.x,p.y);
        /** 通过坐标活的当前cell indexPath */
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:CGPointMake(p.x, p.y + 64)];
//        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
        NSLog(@"%ld",(long)indexPath.row);
        /** 获得当前cell */
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        
        PeekViewController *peekViewController = [[PeekViewController alloc] init];
        //    detail.preferredContentSize = CGSizeMake(0, 120);
//        peekViewController.view.frame = self.view.frame;
        peekViewController.preferredContentSize = CGSizeMake(0.0, 300);
//        CGRect rect = CGRectMake(20 , 20, SCREEN_WIDTH - 40 , cell.frame.size.height + 10);
        CGRect rect = cell.frame;
        NSLog(@"frame : %@",NSStringFromCGRect(cell.frame));
        previewingContext.sourceRect = rect;

        
        return peekViewController;
        
    }
}
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 生命周期
//- (void)viewWillAppear:(BOOL)animated{
//    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//        NSLog(@"3DTouch 可以使用");
//    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnavailable){
//        NSLog(@"3DTouch 不可使用");
//    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnknown){
//        NSLog(@"3DTouch 未知");
//    }
//}
////当然在生命周期内，如果用户有意修改了设备的3D Touch功能，我们还有一个地方来重新检测：
//- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    //do something
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"这是第几%ld个Cell",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"你点击了第%ld条项目",indexPath.row);
}



@end
