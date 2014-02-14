//
//  WCUserProfileViewController.m
//  微信
//
//  Created by Reese on 13-8-14.
//  Copyright (c) 2013年 Reese. All rights reserved.
//

#import "WCUserProfileViewController.h"
#import "ASIFormDataRequest.h"

@interface WCUserProfileViewController ()

@end

@implementation WCUserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"hahaha-------%@",_thisUser.userNickname);
    [userHead setWebImage:FILE_BASE_URL(_thisUser.userHead) placeHolder:[UIImage imageNamed:@"mb.png"] downloadFlag:10000];
    [nickName.layer setCornerRadius:25];
    [nickName.layer setMasksToBounds:YES];
    [nickName setText:_thisUser.userNickname];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

-(void)dealloc
{
    [super dealloc];
    [_thisUser release];
}

- (IBAction)deleteFriend:(id)sender {
    /* 添加好友接口 */
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:API_BASE_URL(@"deleteFriend.do")];
    
    [request setPostValue:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_API_KEY ] forKey:@"apiKey"];
    [request setPostValue:_thisUser.userId forKey:@"userId"];
    [MMProgressHUD showWithTitle:@"删除好友" status:@"请求中..." ];
    [request setCompletionBlock:^{
        NSLog(@"response:%@",request.responseString);
        SBJsonParser *paser=[[[SBJsonParser alloc]init]autorelease];
        NSDictionary *rootDic=[paser objectWithString:request.responseString];
        int resultCode=[[rootDic objectForKey:@"status"]intValue];
        if (resultCode==1) {
            [MMProgressHUD dismissWithSuccess:[rootDic objectForKey:@"msg"] title:@"删除好友成功" afterDelay:0.75f];
            
            
            
            
        }else
        {
            [MMProgressHUD dismissWithError:[rootDic objectForKey:@"msg"] title:@"删除好友失败" afterDelay:0.75f];
        }
        
    }];
    
    [request setFailedBlock:^{
        [MMProgressHUD dismissWithError:@"链接服务器失败！" title:@"删除好友失败" afterDelay:0.75f];
    }];
    
    [request startAsynchronous];
}
- (IBAction)addFirend:(id)sender {
    
    /* 添加好友接口 */
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:API_BASE_URL(@"addFriend.do")];
    
    [request setPostValue:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_API_KEY ] forKey:@"apiKey"];
    [request setPostValue:_thisUser.userId forKey:@"userId"];
    [MMProgressHUD showWithTitle:@"添加好友" status:@"请求中..." ];
    [request setCompletionBlock:^{
        NSLog(@"response:%@",request.responseString);
        SBJsonParser *paser=[[[SBJsonParser alloc]init]autorelease];
        NSDictionary *rootDic=[paser objectWithString:request.responseString];
        int resultCode=[[rootDic objectForKey:@"status"]intValue];
        if (resultCode==1) {
            [MMProgressHUD dismissWithSuccess:[rootDic objectForKey:@"msg"] title:@"添加好友成功" afterDelay:0.75f];
           
            
            
            
        }else
        {
            [MMProgressHUD dismissWithError:[rootDic objectForKey:@"msg"] title:@"添加好友失败" afterDelay:0.75f];
        }
        
    }];
    
    [request setFailedBlock:^{
        [MMProgressHUD dismissWithError:@"链接服务器失败！" title:@"添加好友失败" afterDelay:0.75f];
    }];
    
    [request startAsynchronous];
    
    
    [[WCXMPPManager sharedInstance]addSomeBody:_thisUser.userId];
    
}





@end
