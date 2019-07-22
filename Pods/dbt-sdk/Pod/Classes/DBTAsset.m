//
//  DBTAsset.m
//  Pods
//
//  Created by Brandon Trebitowski on 9/8/14.
//
//

#import "DBTAsset.h"

@implementation DBTAsset
- (id) initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if (self) {
        self.server = dict[@"server"];
        self.rootPath = dict[@"root_path"];
        self.protocol = dict[@"protocol"];
        self.cdn = dict[@"CDN"];
        self.priority = dict[@"priority"];
        self.volumeId = dict[@"volume_id"];
    }
    return self;
}
@end
