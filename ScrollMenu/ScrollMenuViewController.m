//
//  ScrollMenuViewController.m
//  ScrollMenu
//
//  Created by nirvana on 14-9-9.
//  Copyright (c) 2014年 Nirvana. All rights reserved.
//

#import "ScrollMenuViewController.h"
#import "TouchPropagatedScrollView.h"

#define ZT_HEIGHT 30
#define NAV_HEIGHT 30

@interface ScrollMenuViewController ()
{
    UIView *_navView;
    UIView *_topNaviV;
    UIScrollView *_scrollV;
    UIView *_selectTabV;
    TouchPropagatedScrollView *_navScrollV;    
}

@end

@implementation ScrollMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    _navView = [[UIView alloc] initWithFrame:CGRectMake(40, 30, 270, 80)];
    ((UIImageView *)_navView).backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_navView];
    _navView.userInteractionEnabled = YES;
    */
    
    _topNaviV = [[UIView alloc] initWithFrame:CGRectMake(0, ZT_HEIGHT, self.view.frame.size.width, NAV_HEIGHT)];
    _topNaviV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_topNaviV];
    
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ZT_HEIGHT+NAV_HEIGHT, self.view.frame.size.height-(ZT_HEIGHT+NAV_HEIGHT), self.view.frame.size.width)];
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view insertSubview:_scrollV belowSubview:_topNaviV];
    
    /*
    _selectTabV = [[UIView alloc]initWithFrame:CGRectMake(60, 50, 300, 90)];
    [_selectTabV setBackgroundColor:[UIColor redColor]];
    [_selectTabV setHidden:YES];
    [self.view insertSubview:_selectTabV belowSubview:_navView];
    */
    
    float btnW = 30;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(_topNaviV.frame.size.width-btnW, 0, btnW, NAV_HEIGHT)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [_topNaviV addSubview:btn];
    
    
    NSArray *arT = @[@"测试1", @"测试2", @"测试3", @"测试4", @"测试5", @"测试6", @"测试7", @"测试8", @"测试9", @"测试10"];
    _navScrollV = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, _topNaviV.frame.size.width - btn.frame.size.width, NAV_HEIGHT)];
    [_navScrollV setBackgroundColor:[UIColor blueColor]];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    for (int i =0; i <[arT count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(60 * i, 0, 60, 36)];
        [btn setTitle:[arT objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        if(i == 0)
        {
            [btn setBackgroundColor:[UIColor blueColor]];
            btn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        }else
        {
            btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        }
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navScrollV addSubview:btn];
    }
    [_navScrollV setContentSize:CGSizeMake(60 * [arT count], NAV_HEIGHT)];
    [_topNaviV addSubview:_navScrollV];
    

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - action

- (void)actionbtn:(UIButton *)btn
{
    [_scrollV scrollRectToVisible:CGRectMake(_scrollV.frame.size.width * (btn.tag - 1), _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height) animated:YES];
    
    float xx = _scrollV.frame.size.width * (btn.tag - 1) * (60 / self.view.frame.size.width) - 60;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
