//
//  DBTAudioVerseStart.m
//  Pods
//
//  Created by Brandon Trebitowski on 9/9/14.
//
//

#import "DBTAudioVerseStart.h"

@implementation DBTAudioVerseStart
- (id) initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if (self) {
        self.verseId = dict[@"verse_id"];
        self.verseStart = dict[@"verse_start"];
    }
    return self;
}
@end
