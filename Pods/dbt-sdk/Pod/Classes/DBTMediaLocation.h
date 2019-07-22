//
//  DBTMediaLocation.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/22/14.
//
//

#import "DBTObject.h"

@interface DBTMediaLocation : DBTObject
@property(nonatomic, strong) NSNumber *cdn;
@property(nonatomic, strong) NSNumber *priority;
@property(nonatomic, strong) NSString *protocol;
@property(nonatomic, strong) NSString *rootPath;
@property(nonatomic, strong) NSString *server;
@property(nonatomic, strong) NSString *baseURL;
- (id) initWithDictionary:(NSDictionary *) dict;
@end
