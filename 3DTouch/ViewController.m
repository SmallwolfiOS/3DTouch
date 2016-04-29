//
//  ViewController.m
//  3DTouch
//
//  Created by Jason on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "TouchedView.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"Boundle identifier" localizedTitle:@"第二个标签" localizedSubtitle:@"subtitle" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite] userInfo:nil];
    UIApplicationShortcutItem * item2 = [[UIApplicationShortcutItem alloc]initWithType:@"Custom Icon" localizedTitle:@"第三个标签" localizedSubtitle:@"详细标题" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"R2"] userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[item,item2];
    
    /**
     *  如果3Dtouch可用，注册代理
     */
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        
        NSLog(@"3D Touch is available! Hurra!");
        
        // no need for our alternative anymore
        
    } else {
        
        NSLog(@"3D Touch is not available on this device. Sniff!");
        
        // handle a 3D Touch alternative (long gesture recognizer)
        
    }
    
    [self customSubViews];
    
    
}
- (void)customSubViews{
    TouchedView * touchView = [[TouchedView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 100)];
    [self.view addSubview:touchView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"3DTouch 可以使用");
    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnavailable){
        NSLog(@"3DTouch 不可使用");
    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnknown){
        NSLog(@"3DTouch 未知");
    }
}
//当然在生命周期内，如果用户有意修改了设备的3D Touch功能，我们还有一个地方来重新检测：
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    //do something
}


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
