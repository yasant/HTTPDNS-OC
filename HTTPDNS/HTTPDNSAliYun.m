//
//  HTTPDNSAliYun.m
//  HTTPDNS
//
//  Created by YourtionGuo on 6/14/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

#import "HTTPDNSAliYun.h"

@implementation HTTPDNSAliYun
{
    NSString *_accountId;
}

- (instancetype)init
{
    return [self initWithAccountId:@"100000"];
}

- (instancetype)initWithAccountId:(NSString *)account
{
    self = [super init];
    if (self) {
        _accountId = account;
    }
    return self;
}

-(NSString *)getRequestString:(NSString *)domain {
    return [NSString stringWithFormat:@"%@/%@/d?host=%@",kHTTPDNS_ALIYUN_SERVER_ADDRESS, _accountId, domain];
}

-(HTTPDNSRecord *)parseResult:(NSData *)data {
    NSError *jsonError;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    NSArray *ipArray = [jsonDic objectForKey:@"ips"];
    int ttl = [[jsonDic objectForKey:@"ttl"] intValue];
    return [[HTTPDNSRecord alloc] init:ipArray ttl:ttl];
}

@end