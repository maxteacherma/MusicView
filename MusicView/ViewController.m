//
//  ViewController.m
//  MusicView
//
//  Created by macbook on 16/1/8.
//  Copyright © 2016年 DLD. All rights reserved.
//

#import "ViewController.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic,assign)BOOL canceled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = [self creatViewWithCount:10];
    [self.view addSubview:view];
}

- (UIView *)creatViewWithCount:(NSInteger )count{
    UIView * view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    CGFloat countWidth = view.frame.size.width/count;
    CGFloat space = countWidth/10;
    CGFloat width = (view.frame.size.width-space*(count+1))/count;
    
    for (int i = 0 ; i<count; i++) {
        CGFloat randomHeight = arc4random()%(NSInteger)(view.frame.size.height-1);
        UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(space+i*(space+width), view.frame.size.height-randomHeight, width, randomHeight)];
        subView.backgroundColor = [UIColor blueColor];
        
        [self startAnimation:subView space:space i:i andWidth:width];
        
        [view addSubview:subView];
    }
    
    return view;
}

- (void)startAnimation:(UIView *)subView space:(CGFloat )space i:(CGFloat)i andWidth:(CGFloat)width{
    __weak UIView * weakView = subView;
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         CGFloat randomHeight = arc4random()%(NSInteger)(SCREEN_HEIGHT);
                         weakView.frame = CGRectMake(space+i*(space+width), SCREEN_HEIGHT-randomHeight, width, randomHeight);
                     }
                     completion:^(BOOL finished) {
                         if(!self.canceled) {
                             __weak id weakSelf = self;
                             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                 [weakSelf startAnimation:subView
                                                    space:space
                                                        i:i
                                                 andWidth:width];
                             }];
                         }
                     }
     ];
}

- (void)resultWithArray:(NSArray *)array andN:(NSInteger)n{
    for (int i = 0; i<array.count-1; i++) {
        NSInteger numberIntA = [array[i] integerValue];
        NSInteger sum = 0;
        for (int j = i+1; j<array.count; j++) {
            NSInteger numberIntB = [array[j] integerValue];
            sum = numberIntA + numberIntB;
            if (n == sum) {
                NSInteger min = numberIntA<numberIntB?numberIntA:numberIntB;
                NSInteger max = numberIntA>numberIntB?numberIntA:numberIntB;
                NSLog(@"(%ld,%ld)",min,max);
                return;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
