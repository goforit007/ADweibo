//
//  WeiboModel.m
//  ADweibo
//
//  Created by fad on 14-11-10.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "WeiboModel.h"
#import "UserModel.h"
#import "NSDate+MJ.h"

@implementation WeiboModel

//修改时间格式
-(NSString *)created_at{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    //真机这里createdDate为空 必须设置时区为en_US  告诉真机这个时间格式是en_US得
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}
//修改来源格式
- (void)setSource:(NSString *)source{
    _source=source;
    if(_source.length){
        int startLoc=[source rangeOfString:@">"].location+1;
        int endLoc=[source rangeOfString:@"</"].location-startLoc;
        NSString *newSource=[source substringWithRange:NSMakeRange(startLoc, endLoc)];
        _source=[NSString stringWithFormat:@"来自:%@",newSource];
    }
    
    //<a href="http://app.weibo.com/t/feed/5g0B8s" rel="nofollow">微博 weibo.com</a>
}

//修改转发微博@
-(void)setRetweeted_status:(WeiboModel *)retweeted_status{
    _retweeted_status=retweeted_status;
    if(retweeted_status){
        NSString *newName=[NSString stringWithFormat:@"@%@",_retweeted_status.user.name];
        _retweeted_status.user.name=newName;
    }
}


/*
-(void)statusWithDict:(NSDictionary *)weiboDict{
    self.created_at=weiboDict[@"created_at"];
    self.mid=weiboDict[@"mid"];
    self.idstr=weiboDict[@"idstr"];
    self.text=weiboDict[@"text"];
    self.thumbnail_pic=weiboDict[@"thumbnail_pic"];
    self.bmiddle_pic=weiboDict[@"bmiddle_pic"];
    self.original_pic=weiboDict[@"original_pic"];
    
    User *user=[[User alloc]init];
    [user statusWithDict:weiboDict[@"user"]];
    self.user=user;
    
    if(weiboDict[@"retweeted_status"]) {
        WeiboModel *retweeted_status=[[WeiboModel alloc]init];
        [retweeted_status statusWithDict:weiboDict[@"retweeted_status"]];
        self.retweeted_status=retweeted_status;
    }
    
    self.reposts_count=weiboDict[@"reposts_count"];
    self.comments_count=weiboDict[@"comments_count"];
    self.attitudes_count=weiboDict[@"attitudes_count"];
    self.pic_urls=weiboDict[@"pic_urls"];
}*/

@end
