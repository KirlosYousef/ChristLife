//
//  DBTVolumeOrganization.m
//  Pods
//
//  Created by Brandon Trebitowski on 9/8/14.
//
//

#import "DBTVolumeOrganization.h"

@implementation DBTVolumeOrganization

- (id) initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if (self) {
        self.numberVolumes = dict[@"number_volumes"];
        self.organizationName = dict[@"organization_name"];
        self.organizationId = dict[@"organization_id"];
    }
    return self;
}

@end
