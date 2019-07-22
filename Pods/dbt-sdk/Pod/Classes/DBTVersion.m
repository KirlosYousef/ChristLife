//
//  DBTLibraryVersion.m
//  Pods
//
//  Created by Brandon Trebitowski on 9/7/14.
//
//

#import "DBTVersion.h"

@implementation DBTVersion

- (id) initWithDictionary:(NSDictionary *) dict {
    self = [super init];
    if(self) {
        self.versionCode = dict[@"version_code"];
        self.versionName = dict[@"version_name"];
        self.englishName = dict[@"english_name"];
    }
    return self;
}

@end
