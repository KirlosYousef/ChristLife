//
//  DBTVersion.h
//  Pods
//
//  Created by Brandon Trebitowski on 9/7/14.
//
//

#import "DBTObject.h"

@interface DBTVersion : DBTObject
@property(nonatomic, strong) NSString *versionCode;
@property(nonatomic, strong) NSString *versionName;
@property(nonatomic, strong) NSString *englishName;
- (id) initWithDictionary:(NSDictionary *) dict;
@end
