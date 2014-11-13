//
//  ADHomeTableViewController.m
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADHomeTableViewController.h"
#import "UIImage+AD.h"
#import "UIBarButtonItem+Custom.h"
#import "TitleButton.h"
#import "AlertView.h"
#import "WeiboSDK.h"
#import "WeiboModel.h"
#import "WeiboFrameModel.h"
#import "UserModel.h"
#import "MJExtension.h"
#import "SinaOAuth.h"
#import "WeiboCell.h"

@interface ADHomeTableViewController ()<WBHttpRequestDelegate>

@property(nonatomic,strong)AlertView *alertView;
@property(nonatomic,strong)NSMutableArray *weiboFrames;


@end

@implementation ADHomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //因为cellY值都增加了kTableBorder，相应的要增加tableview的滚动范围
        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, kTableBorder, 0);
    }
    return self;
}

- (NSMutableArray *)weiboFrames{
    if (_weiboFrames==nil) {
        _weiboFrames=[NSMutableArray arrayWithCapacity:20];
    }
    return _weiboFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置barbuttonitem
    [self initBarButtonItem];
    //请求微博数据
    [self loadWeibo];
}
-(void)initBarButtonItem{
    //左边
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem initWithNormalBackgroundImage:@"navigationbar_friendsearch" HighlightedBackgroundImage:@"navigationbar_friendsearch_highlighted" Target:self action:@selector(findFriend:)];
    //右边
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem initWithNormalBackgroundImage:@"navigationbar_pop" HighlightedBackgroundImage:@"navigationbar_pop_highlighted" Target:self action:@selector(pop:)];
    //中间
    TitleButton *titleBtn=[TitleButton titleButton];
    NSString *userName=@"哈哈";
    [titleBtn setTitle:userName forState:UIControlStateNormal];
    CGSize valueSize=[userName sizeWithFont:titleBtn.titleLabel.font];
    titleBtn.frame=CGRectMake(0, 0, valueSize.width+40, 30);
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=titleBtn;
}

-(void)findFriend:(UIBarButtonItem *)item{
    NSLog(@"findFriend");
}
-(void)pop:(UIBarButtonItem *)item{
    NSLog(@"pop");
}
-(void)titleBtnClick:(TitleButton *)btn{
    //点击中间按钮时，变换箭头方向
    [UIView beginAnimations:nil context:nil];
    btn.imageView.transform=CGAffineTransformRotate(btn.imageView.transform, M_PI);
    [UIView commitAnimations];
     //弹出框
    if(self.alertView){
        [self.alertView removeFromSuperview];
        self.alertView=nil;
        return;
    }
    NSArray *array=@[@"首页",@"好友圈",@"我的微博",@"周边微博",@"特别关注",@"同学",@"同事",@"家人",@"朋友",@"明星",@"其他"];
    self.alertView=[[AlertView alloc]initWithData:array];
    CGFloat alertW=180;
    CGFloat alertH=280;
    self.alertView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-alertW/2, 65, alertW, alertH);
    [self.navigationController.view addSubview:self.alertView];
}

-(void)loadWeibo{
    SinaOAuth *oauth=[SinaOAuth oauth];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:@{@"access_token":oauth.token} delegate:self withTag:@"friends_timeline"];
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data;{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"收到请求微博回应");
    NSArray *dictArray=dict[@"statuses"];
    for (NSDictionary *dict in dictArray) {
        WeiboModel *weibo=[WeiboModel objectWithKeyValues:dict];
        WeiboFrameModel *frame=[[WeiboFrameModel alloc]init];
        frame.weibo=weibo;
        [self.weiboFrames addObject:frame];
        NSLog(@"%@",weibo.user.name);
        NSLog(@"%@",weibo.pic_urls);
    }
    [self.tableView reloadData];
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"home请求错误");
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"cell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    WeiboFrameModel *weiboFrame=self.weiboFrames[indexPath.row];
    cell.weiboFrame=weiboFrame;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*UIViewController *ctrl=[[UIViewController alloc]init];
    ctrl.view.backgroundColor=[UIColor grayColor];
    [self.navigationController pushViewController:ctrl animated:YES];*/
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    WeiboFrameModel *weiboFrame=self.weiboFrames[indexPat.row];
    return weiboFrame.cellH;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.alertView removeFromSuperview];
    self.alertView=nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
