//
//  DBTMediaLocation.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/22/14.
//
//

#import "DBTMediaLocation.h"

@implementation DBTMediaLocation
- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {        
        self.cdn = dict[@"CDN"];
        self.priority = dict[@"priority"];
        self.protocol = dict[@"protocol"];
        self.rootPath = dict[@"root_path"];
        self.server = dict[@"server"];
    }
    return self;
}

- (NSString *) baseURL
{
    return [NSString stringWithFormat:@"%@://%@%@",_protocol,_server, _rootPath];
}

@end
