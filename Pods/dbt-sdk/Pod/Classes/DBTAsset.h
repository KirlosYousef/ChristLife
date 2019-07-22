//
//  DBTAsset.h
//  Pods
//
//  Created by Brandon Trebitowski on 9/8/14.
//
//

#import "DBTObject.h"

@interface DBTAsset : DBTObject
@property(nonatomic, strong) NSString *server;
@property(nonatomic, strong) NSString *rootPath;
@property(nonatomic, strong) NSString *protocol;
@property(nonatomic, strong) NSNumber *cdn;
@property(nonatomic, strong) NSNumber *priority;
@property(nonatomic, strong) NSString *volumeId;
@end
