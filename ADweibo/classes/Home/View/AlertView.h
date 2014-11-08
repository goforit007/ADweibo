//
//  alertView.h
//  ADweibo
//
//  Created by fad on 14-11-8.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *BGimage;

- (id)initWithData:(NSArray *)data;

@end
