//
//  DBTLibraryChapter.h
//  Pods
//
//  Created by Brandon Trebitowski on 9/7/14.
//
//

#import "DBTObject.h"

@interface DBTChapter : DBTObject
@property(nonatomic, strong) NSString *damId;
@property(nonatomic, strong) NSString *bookId;
@property(nonatomic, strong) NSString *chapterId;
@property(nonatomic, strong) NSString *chapterName;
@property(nonatomic, strong) NSString *isDefault;
@end
