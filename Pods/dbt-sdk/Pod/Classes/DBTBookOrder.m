//
//  DBTBookOrder.m
//  Pods
//
//  Created by Brandon Trebitowski on 9/7/14.
//
//

#import "DBTBookOrder.h"

@implementation DBTBookOrder
- (id) initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if(self) {
        self.bookOrder = dict[@"book_order"];
        self.bookId = dict[@"book_id"];
        self.bookName = dict[@"book_name"];
        self.damIdRoot = dict[@"dam_id_root"];
    }
    return self;
}
@end
