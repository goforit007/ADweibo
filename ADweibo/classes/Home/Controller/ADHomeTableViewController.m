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

@interface ADHomeTableViewController ()

@property(nonatomic,strong)AlertView *alertView;

@end

@implementation ADHomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置barbuttonitem
    [self initBarButtonItem];
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
    self.alertView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2-alertW/2, 0, alertW, alertH);
    [self.alertView resignFirstResponder];
    [self.tableView addSubview:self.alertView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=@"123";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *ctrl=[[UIViewController alloc]init];
    ctrl.view.backgroundColor=[UIColor grayColor];
    
    [self.navigationController pushViewController:ctrl animated:YES];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
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
