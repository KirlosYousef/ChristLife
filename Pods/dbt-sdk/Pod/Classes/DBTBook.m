//
//  DBTBook.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTBook.h"

@implementation DBTBook

- (id) initWithDictionary:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.bookId = dict[@"book_id"];
        self.bookName = dict[@"book_name"];
        self.bookOrder = dict[@"book_order"];
        self.chapters = dict[@"chapters"];
        self.damId = dict[@"dam_id"];
        self.numberOfChapters = dict[@"number_of_chapters"];
    }
    return self;
}

@end
