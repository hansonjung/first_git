//
//  NetworkModule.m
//  Network_login
//
//  Created by Hanson Jung on 2017. 3. 21..
//  Copyright © 2017년 waaoo. All rights reserved.
//

#import "NetworkModule.h"

@implementation NetworkModule

+ (void)signpWithUsername:(NSString *)userName
             withPassword:(NSString *)passWord
      withPasswordReEnter:passWordReEnter
          completionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock {
  
    //session 객체 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //Request 생성
    NSURL *url = [NSURL URLWithString:@"https://fc-ios.lhy.kr/api/member/signup/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *noteDataString = [NSString stringWithFormat:@"username=%@&password1=%@&password2=%@", userName, passWord, passWordReEnter];
    NSLog(@"network %@", userName);
    
    //body data set
    request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    //post task 요청
    NSURLSessionUploadTask *postDataTask = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //응답에 대한 처리
        if (error == nil) {
            NSDictionary *responsData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"signup success");
            //아이디나 패스워드가 틀렸을때도 이리 넘어왔는데 그건 로그인이 틀렸다는 거지 시스템 에러라는 뜻이 아님.
            NSLog(@"%@", responsData);
            //completion(NO, responsData);
            
                           
        
            
        } else {
            NSDictionary *responsData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"system error");
            NSLog(@"%@", responsData);
            
            //completion(YES, responsData);
        }
    }];
    
    [postDataTask resume];

    
}

@end
