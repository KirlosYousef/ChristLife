//
//  DBTVideoPath.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/22/14.
//
//

#import "DBTVideoPath.h"

@implementation DBTVideoPath

- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.bookId = dict[@"book_id"];
        self.chapterEnd = dict[@"chapter_end"];
        self.chapterStart = dict[@"chapter_start"];
        self.path = dict[@"path"];
        self.references = dict[@"references"];
        self.relatedVideos = dict[@"related_videos"];
        self.segmentOrder = dict[@"segment_order"];
        self.thumbnailImage = dict[@"thumbnail_image"];
        self.title = dict[@"title"];
        self.verseEnd = dict[@"verse_end"];
        self.verseStart = dict[@"verse_start"];
    }
    return self;
}

@end
