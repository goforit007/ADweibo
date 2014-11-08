//
//  alertView.m
//  ADweibo
//
//  Created by fad on 14-11-8.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "AlertView.h"
#import "UIImage+AD.h"

@implementation AlertView

- (id)initWithData:(NSArray *)data{
    self=[super init];
    if(self){
        NSLog(@"initWithData");
        //table
        self.userInteractionEnabled=YES;
        self.data=data;
        self.tableView=[[UITableView alloc]init];
        self.tableView.dataSource=self;
        self.tableView.Delegate=self;
        self.tableView.backgroundColor=[UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //背景图
        UIImage *img=[UIImage imageWithName:@"popover_background"];
        img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:img];
        [imageview setImage:img];
        self.BGimage=[[UIImageView alloc]init];
        self.BGimage.image=img;
        
        [self addSubview:self.BGimage];
        [self addSubview:self.tableView];
        
        
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=self.data[indexPath.row];
    cell.textLabel.Font=[UIFont systemFontOfSize:16];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
//禁止选中
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)layoutSubviews{
    self.BGimage.frame=self.bounds;
    self.tableView.frame=CGRectMake(0, 12, self.bounds.size.width, self.bounds.size.height-17);
}

@end





