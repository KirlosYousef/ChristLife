//
//  DBTVerse.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTObject.h"

@interface DBTVerse : DBTObject
@property(nonatomic, strong) NSString *bookId;
@property(nonatomic, strong) NSString *bookName;
@property(nonatomic, strong) NSNumber *bookOrder;
@property(nonatomic, strong) NSNumber *chapterId;
@property(nonatomic, strong) NSString *chapterTitle;
@property(nonatomic, strong) NSNumber *paragraphNumber;
@property(nonatomic, strong) NSNumber *verseId;
@property(nonatomic, strong) NSString *verseText;
- (id) initWithDictionary:(NSDictionary *) dict;
@end
