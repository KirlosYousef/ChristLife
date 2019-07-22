//
//  DBTVideoPath.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/22/14.
//
//

#import "DBTObject.h"

@interface DBTVideoPath : DBTObject
@property(nonatomic, strong) NSString *bookId;
@property(nonatomic, strong) NSNumber *chapterStart;
@property(nonatomic, strong) NSNumber *chapterEnd;
@property(nonatomic, strong) NSNumber *verseStart;
@property(nonatomic, strong) NSNumber *verseEnd;
@property(nonatomic, strong) NSString *path;
@property(nonatomic, strong) NSNumber *segmentOrder;
@property(nonatomic, strong) NSArray *relatedVideos;
@property(nonatomic, strong) NSArray *references;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *thumbnailImage;
- (id) initWithDictionary:(NSDictionary *) dict;
@end
