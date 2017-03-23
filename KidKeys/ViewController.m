//
//  ViewController.m
//  KidKeys
//
//  Created by kangZhe on 10/30/14.
//  Copyright (c) 2014 com.spark.keyboarddesigner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rt = [[UIScreen mainScreen] bounds];
    NSString *filename = @"";
    int height = rt.size.height;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:rt];
    [self.view addSubview:imageview];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        filename = @"how-to_ipad.png";
    }else{
        switch(height){
            case 480:case 960:
                filename = @"how-to_iphone4.png";
                break;
            case 568:case 1136:
                filename = @"how-to_iphone5.png";
                break;
            case 667:case 1334:
                filename = @"how-to_iphone6.png";
                break;
            case 736:case 1104:case 2208:
                filename = @"how-to_iphone6plus.png";
                break;
        }
    }
    imageview.image = [UIImage imageNamed:filename];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
