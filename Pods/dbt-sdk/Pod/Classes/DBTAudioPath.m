//
//  DBTAudioPath.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/22/14.
//
//

#import "DBTAudioPath.h"

@implementation DBTAudioPath
- (id) initWithDictionary:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.bookId = dict[@"book_id"];
        self.chapterId = dict[@"chapter_id"];
        self.path = dict[@"path"];
    }
    return self;
}
@end
