//
//  DBTAudioPath.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/22/14.
//
//

#import "DBTObject.h"

@interface DBTAudioPath : DBTObject
@property(nonatomic, strong) NSString *bookId;
@property(nonatomic, strong) NSNumber *chapterId;
@property(nonatomic, strong) NSString *path;
- (id) initWithDictionary:(NSDictionary *) dict;
@end
