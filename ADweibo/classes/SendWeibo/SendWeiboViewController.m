//
//  SendWeiboViewController.m
//  ADweibo
//
//  Created by fad on 14-11-15.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "SendWeiboViewController.h"
#import "SinaOAuth.h"
#import "WeiboSDK.h"
#import "MBProgressHUD+Add.h"
#import "SendToolBar.h"
#import "UIView+frameExtension.h"

@interface SendWeiboViewController ()<WBHttpRequestDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)SendToolBar *toolbar;

@end

@implementation SendWeiboViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.view.backgroundColor=[UIColor clearColor];
        self.title=@"发微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置导航栏
    [self initNaviBar];
    //设置文本框
    [self setTextView];
    //添加工具条
    [self setToolBar];
    //监听按钮点击
    [self btnClick];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //第一次调出键盘会有点卡，所以放在viewDidAppear里面，不影响界面的显示
    [self.textView becomeFirstResponder];
}

-(void)initNaviBar{
    //取消按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    //发送按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
}

-(void)setToolBar{
    self.toolbar=[[SendToolBar alloc]init];
    CGFloat X=0;
    CGFloat H=44;
    CGFloat Y=self.view.frame.size.height-H;
    CGFloat W=self.view.frame.size.width;
    self.toolbar.frame=CGRectMake(X, Y, W, H);
    [self.view addSubview:self.toolbar];
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}
//键盘弹出来的时候
-(void)KeyboardChange:(NSNotification *)note{
    //键盘弹出世间
    //double duration=[note.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    //键盘高度
    CGRect keyBoardFrame=[note.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.toolbar.Y=self.view.height-keyBoardFrame.size.height-self.toolbar.height;
}

-(void)setTextView{
    /*
     UITextField 不能换行
     UITextView  没有提示文字
     
     用继承UITextView添加提示文字
     */
    self.textView=[[UITextView alloc]init];
    self.textView.font=[UIFont systemFontOfSize:16];
    self.textView.frame=self.view.bounds;
    [self.view addSubview:self.textView];
    //监听开始编辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditing) name:UITextViewTextDidBeginEditingNotification object:self.textView];
    //监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.textView];
}
//文字改变
-(void)textChange{
    if(self.textView.text.length){
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
}
//开始编辑
-(void)textEditing{
    if([self.textView.text isEqualToString:@"新鲜事"]){
        self.textView.text=@"";
    }
}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//发微博
-(void)send{
    SinaOAuth *oauth=[SinaOAuth oauth];
    NSString *status=self.textView.text;
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:@{@"access_token":oauth.token,@"status":status} delegate:self withTag:@"loadWeibo"];
}
//微博发送响应
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSLog(@"request:%@",request);
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *weiboID=dict[@"idstr"];
    if(weiboID){
        NSLog(@"微博发送成功:%@",weiboID);
        [MBProgressHUD showSuccess:@"发送成功" toView:nil];
    }else{
        NSLog(@"微博发送失败:%@",dict);
        [MBProgressHUD showError:@"发送失败" toView:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//微博发送错误
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"微博发送时错误");
    [MBProgressHUD showError:@"发送错误" toView:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)btnClick{
    __weak typeof(self) tempSentCtrl=self;
    self.toolbar.toolBarButtonClickBlock=^(toolBarButtonType type){
        switch (type) {
            case toolBarButtonTypeCamera://相机
                [tempSentCtrl openPicture:UIImagePickerControllerSourceTypeCamera];
                break;
            case toolBarButtonTypePicture://图片
                [tempSentCtrl openPicture:UIImagePickerControllerSourceTypePhotoLibrary];
                break;
            case toolBarButtonTypeMention://@
                break;
            case toolBarButtonTypeTrend://话题
                break;
            case toolBarButtonTypeEmotion://表情
                break;
            default:
                break;
        }
    };
}

//打开相机或图库
-(void)openPicture:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=sourceType;
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
}
//相册选择后的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editin{
    NSLog(@"拿到图片:%@",image);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
