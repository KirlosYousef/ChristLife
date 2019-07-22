//
//  DBTBook.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTObject.h"

@interface DBTBook : DBTObject

@property(nonatomic, strong) NSString *bookId;
@property(nonatomic, strong) NSString *bookName;
@property(nonatomic, strong) NSNumber *bookOrder;
@property(nonatomic, strong) NSString *chapters;
@property(nonatomic, strong) NSString *damId;
@property(nonatomic, strong) NSNumber *numberOfChapters;
- (id) initWithDictionary:(NSDictionary *) dict;
@end
