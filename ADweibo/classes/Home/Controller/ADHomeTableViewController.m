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
#import "MJRefresh.h"

@interface ADHomeTableViewController ()<WBHttpRequestDelegate>

@property(nonatomic,strong)AlertView *alertView;
@property(nonatomic,strong)NSMutableArray *weiboFrames;
@property(nonatomic,strong)UIRefreshControl *freshCtrl;
@property(nonatomic,strong)TitleButton *titleBtn;

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
    //获取用户信息
    [self loadUserInfo];
    //设置上拉下拉刷新
    [self setRefFreshView];
    //每隔60s请求一次未读微博数目
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(UnreadWeiboMonitor) userInfo:nil repeats:YES];

}
-(void)initBarButtonItem{
    //左边
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem initWithNormalBackgroundImage:@"navigationbar_friendsearch" HighlightedBackgroundImage:@"navigationbar_friendsearch_highlighted" Target:self action:@selector(findFriend:)];
    //右边
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem initWithNormalBackgroundImage:@"navigationbar_pop" HighlightedBackgroundImage:@"navigationbar_pop_highlighted" Target:self action:@selector(pop:)];
    //中间
    self.titleBtn=[TitleButton titleButton];
    [self.titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=self.titleBtn;
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
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:@{@"access_token":oauth.token} delegate:self withTag:@"loadWeibo"];
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data;{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"收到请求微博回应:%@",request.tag);
    if([request.tag isEqualToString:@"loadWeibo"]){
        NSArray *dictArray=dict[@"statuses"];
        for (NSDictionary *dict in dictArray) {
            WeiboModel *weibo=[WeiboModel objectWithKeyValues:dict];
            WeiboFrameModel *frame=[[WeiboFrameModel alloc]init];
            frame.weibo=weibo;
            [self.weiboFrames addObject:frame];
        }
    }
    if([request.tag isEqualToString:@"downFresh"]){
        NSArray *dictArray=dict[@"statuses"];
        NSMutableArray *tempArr=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            WeiboModel *weibo=[WeiboModel objectWithKeyValues:dict];
            WeiboFrameModel *frame=[[WeiboFrameModel alloc]init];
            frame.weibo=weibo;
            [tempArr addObject:frame];
        }
        //提示加载了多少新微博
        [self showNewWeiboCount:tempArr.count];
        //将新数据放在旧数据前面
        [tempArr addObjectsFromArray:self.weiboFrames];
        self.weiboFrames=tempArr;
        [self.tableView headerEndRefreshing];
        //清除badgeValue提示
        self.tabBarItem.badgeValue=@"0";
    }
    if([request.tag isEqualToString:@"upFresh"]){
        NSArray *dictArray=dict[@"statuses"];
        NSMutableArray *tempArr=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            WeiboModel *weibo=[WeiboModel objectWithKeyValues:dict];
            WeiboFrameModel *frame=[[WeiboFrameModel alloc]init];
            frame.weibo=weibo;
            [tempArr addObject:frame];
        }
        //将新数据放在旧数据后面
        [self.weiboFrames removeLastObject];
        [self.weiboFrames addObjectsFromArray:tempArr];
        [self.tableView footerEndRefreshing];
        
    }
    if ([request.tag isEqualToString:@"userInfo"]) {
        NSString *screen_name=dict[@"screen_name"];
        CGSize valueSize=[screen_name sizeWithFont:self.titleBtn.titleLabel.font];
        self.titleBtn.frame=CGRectMake(0, 0, valueSize.width+40, 30);
        [self.titleBtn setTitle:screen_name forState:UIControlStateNormal];
    }
    if([request.tag isEqualToString:@"Unread"]){
        NSNumber *unreadCount=dict[@"status"];
        NSLog(@"未读微博数:%@",unreadCount);
        if([unreadCount integerValue]>0){
            NSString *unreadStr=[NSString stringWithFormat:@"%@",unreadCount];
            self.tabBarItem.badgeValue=unreadStr;
                        return;
        }
    }
    [self.tableView reloadData];
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"home请求错误");
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    //[self.refreshControl endRefreshing];
}
//刷新功能
-(void)setRefFreshView{
    /*//下拉（系统自带）
    self.refreshControl=[[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(freshCtrlChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];*/
    __unsafe_unretained typeof(self) vc = self;
    //下拉（第三方控件）
    [self.tableView addHeaderWithCallback:^{
        [vc downFresh];
    }];
    //上拉（第三方控件）
    [self.tableView addFooterWithCallback:^{
        [vc upFresh];
    }];
    
}
//下拉刷新
-(void)downFresh{
    SinaOAuth *oauth=[SinaOAuth oauth];
    WeiboFrameModel *firstWeiboFrameModel=[self.weiboFrames firstObject];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:@{@"access_token":oauth.token,@"since_id":firstWeiboFrameModel.weibo.idstr} delegate:self withTag:@"downFresh"];
}
//上拉刷新
-(void)upFresh{
    SinaOAuth *oauth=[SinaOAuth oauth];
    WeiboFrameModel *lastWeiboFrameModel=[self.weiboFrames lastObject];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:@{@"access_token":oauth.token,@"max_id":lastWeiboFrameModel.weibo.idstr} delegate:self withTag:@"upFresh"];
}
/*
//UIRefreshControl 上拉刷新值的改变
-(void)freshCtrlChange:(UIRefreshControl *)freshCtrl{
    SinaOAuth *oauth=[SinaOAuth oauth];
    WeiboFrameModel *firstWeiboFrameModel=[self.weiboFrames firstObject];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" httpMethod:@"GET" params:@{@"access_token":oauth.token,@"since_id":firstWeiboFrameModel.weibo.idstr} delegate:self withTag:@"friends_timeline"].tag=@"downFresh";
}*/
//监视未读微博数目
-(void)UnreadWeiboMonitor{
    SinaOAuth *oauth=[SinaOAuth oauth];
    [WBHttpRequest requestWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" httpMethod:@"GET" params:@{@"access_token":oauth.token,@"uid":oauth.userID} delegate:self withTag:@"Unread"];
}

//显示加载了多少新微博
-(void)showNewWeiboCount:(int)count{
    UIButton *btn=[[UIButton alloc]init];
    CGFloat W=[UIScreen mainScreen].bounds.size.width;
    CGFloat H=40;
    CGFloat Y=self.navigationController.navigationBar.bounds.size.height+H-20;
    btn.frame=CGRectMake(0, 0, W, 40);
    
    UIImage *img=[UIImage imageWithName:@"timeline_new_status_background"];
    img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    NSString *countStr=nil;
    if(count){
        countStr=[NSString stringWithFormat:@"加载了%d条新微博",count];
    }else{
        countStr=@"没有新微博";
    }
    
    [btn setTitle:countStr forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.userInteractionEnabled=NO;
    //显示在item的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:0.5 animations:^{
        btn.frame=CGRectMake(0, Y, W, H);
    } completion:^(BOOL finished) {
        [btn performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.7];
    }];
}
//获取个人信息
-(void)loadUserInfo{
    SinaOAuth *oauth=[SinaOAuth oauth];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"access_token":oauth.token,@"uid":oauth.userID} delegate:self withTag:@"userInfo"];
}
//重复点击时的下拉刷新
-(void)clickAgain{
    [self.tableView headerBeginRefreshing];
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
