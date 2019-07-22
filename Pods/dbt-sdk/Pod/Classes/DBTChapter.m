//
//  DBTChapter
//  Pods
//
//  Created by Brandon Trebitowski on 9/7/14.
//
//

#import "DBTChapter.h"

@implementation DBTChapter
- (id) initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if(self) {
        self.damId = dict[@"dam_id"];
        self.bookId = dict[@"book_id"];
        self.chapterId = dict[@"chapter_id"];
        self.chapterName = dict[@"chapter_name"];
        self.isDefault = dict[@"default"];
    }
    return self;
}
@end
