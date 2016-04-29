//
//  ViewController.m
//  3DTouch
//
//  Created by Jason on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIViewControllerPreviewingDelegate>

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
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    //do something
}
@end
