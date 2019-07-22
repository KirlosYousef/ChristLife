//
//  DBTVerse.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTVerse.h"

@implementation DBTVerse

- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.bookId = dict[@"book_id"];
        self.bookName = dict[@"book_name"];
        self.bookOrder = dict[@"book_order"];
        self.chapterId = dict[@"chapter_id"];
        self.chapterTitle = dict[@"chapter_title"];
        self.paragraphNumber = dict[@"paragraph_number"];
        self.verseId = dict[@"verse_id"];
        self.verseText = dict[@"verse_text"];
    }
    return self;
}

@end
