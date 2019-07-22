//
//  DBT.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBT.h"
#import "DBTConstants.h"

// Models
#import "DBTVolumeLanguage.h"
#import "DBTVolume.h"
#import "DBTBook.h"
#import "DBTVersion.h"
#import "DBTMediaLocation.h"
#import "DBTAudioPath.h"
#import "DBTVideoPath.h"
#import "DBTVerse.h"
#import "DBTBookOrder.h"
#import "DBTChapter.h"
#import "DBTVolumeOrganization.h"
#import "DBTAsset.h"
#import "DBTAudioVerseStart.h"

@implementation DBT

+ (void) setAPIKey:(NSString *) apiKey
{
    [[DBTWebInterface sharedInterface] setApiKey:apiKey];
}

+ (void) query:(NSString *)path
        params:(NSDictionary *) params
      success :(void (^)(id results)) success
       failure:(DBTWebinterfaceFailureBlock) failure {
    [[DBTWebInterface sharedInterface] get:path
                                    params:params
                                   success:^(id response) {
                                       success(response);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

#pragma mark - Text

+ (void) getTextVerseWithDamId:(NSString *) damId
                          book:(NSString *) bookId
                       chapter:(NSNumber *) chapterId
                    verseStart:(NSNumber *) verseStart
                      verseEnd:(NSNumber *) verseEnd
                       success:(void (^)(NSArray *verses)) success
                       failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (bookId)
        params[@"book_id"] = bookId;
    if (chapterId)
        params[@"chapter_id"] = chapterId;
    if (verseStart)
        params[@"verse_start"] = verseStart;
    if (verseEnd)
        params[@"verse_end"] = verseEnd;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathTextVerse
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *verses = [@[] mutableCopy];
                                       for(NSDictionary *verseDict in response)
                                       {
                                           DBTVerse *v = [[DBTVerse alloc] initWithDictionary:verseDict];
                                           [verses addObject:v];
                                       }
                                       success([NSArray arrayWithArray:verses]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getVerseWithDamId:(NSString *) damId
                      book:(NSString *) bookId
                   chapter:(NSNumber *) chapterId
                verseStart:(NSNumber *) verseStart
                  verseEnd:(NSNumber *) verseEnd
                   success:(void (^)(NSArray *verses)) success
                   failure:(DBTWebinterfaceFailureBlock) failure __deprecated {
    [DBT getTextVerseWithDamId:damId
                          book:bookId
                       chapter:chapterId
                    verseStart:verseStart
                      verseEnd:verseEnd
                       success:success
                       failure:failure];
}

+ (void) searchTextWithDamId:(NSString *) damId
                       query:(NSString *) query
                        book:(NSString *) bookId
                      offset:(NSNumber *) offset
                       limit:(NSNumber *) limit
                     success:(void (^)(NSArray *verses, NSInteger totalResults)) success
                     failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (bookId)
        params[@"book_id"] = bookId;
    if (offset)
        params[@"offset"] = offset;
    if (limit)
        params[@"limit"] = limit;
    if (query)
        params[@"query"] = query;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathTextSearch
                                    params:params
                                   success:^(id response) {
                                       NSLog(@"search %@", response);
                                       
                                       NSArray *responseArray = (NSArray *) response;
                                       NSInteger totalResults = [responseArray[0][0][@"total_results"] integerValue];
                                       
                                       NSMutableArray *verses = [@[] mutableCopy];
                                       for(NSDictionary *verseDict in responseArray[1])
                                       {
                                           DBTVerse *v = [[DBTVerse alloc] initWithDictionary:verseDict];
                                           // Force chapter title since this call doesn't return one
                                           v.chapterTitle = [NSString stringWithFormat:@"Chapter %@", v.chapterId];
                                           [verses addObject:v];
                                       }
                                       success([NSArray arrayWithArray:verses],totalResults);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

#pragma mark - Audio

+ (void) getAudioLocation:(NSString *) protocol
                  success:(void (^)(NSArray *languageFamilies)) success
                  failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (protocol)
        params[@"protocol"] = protocol;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathAudioLocation
                                    params:params
                                   success:^(id response) {                                       
                                       NSMutableArray *locationsArray = [@[] mutableCopy];
                                       for(NSDictionary *locationDict in response)
                                       {
                                           DBTMediaLocation *l = [[DBTMediaLocation alloc] initWithDictionary:locationDict];
                                           [locationsArray addObject:l];
                                       }
                                       success([NSArray arrayWithArray:locationsArray]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getAudioPathWithDamId:(NSString *) damId
                          book:(NSString *) bookId
                       chapter:(NSNumber *) chapterId
                       success:(void (^)(NSArray *audioPaths)) success
                       failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (bookId)
        params[@"book_id"] = bookId;
    if (chapterId)
        params[@"chapter_id"] = chapterId;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathAudioPath
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *pathsArray = [@[] mutableCopy];
                                       for(NSDictionary *pathDict in response)
                                       {
                                           DBTAudioPath *p = [[DBTAudioPath alloc] initWithDictionary:pathDict];
                                           [pathsArray addObject:p];
                                       }
                                       success([NSArray arrayWithArray:pathsArray]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getAudioVerseStartWithDamId:(NSString *) damId
                                book:(NSString *) bookId
                             chapter:(NSNumber *) chapterId
                             success:(void (^)(NSArray *audioVerseStarts)) success
                             failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (bookId)
        params[@"osis_code"] = bookId;
    if (chapterId)
        params[@"chapter_number"] = chapterId;
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathAudioVerseStartPath
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *arr = [@[] mutableCopy];
                                       for(NSDictionary *dict in response)
                                       {
                                           DBTAudioVerseStart *obj = [[DBTAudioVerseStart alloc] initWithDictionary:dict];
                                           [arr addObject:obj];
                                       }
                                       success([NSArray arrayWithArray:arr]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

#pragma mark - Video

+ (void) getVideoLocationWithSuccess:(void (^)(NSArray *videoLocations)) success
                             failure:(DBTWebinterfaceFailureBlock) failure;
{
    NSMutableDictionary *params = [@{} mutableCopy];
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathVideoLocation
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *locationsArray = [@[] mutableCopy];
                                       for(NSDictionary *locationDict in response)
                                       {
                                           DBTMediaLocation *l = [[DBTMediaLocation alloc] initWithDictionary:locationDict];
                                           [locationsArray addObject:l];
                                       }
                                       success([NSArray arrayWithArray:locationsArray]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getVideoPathWithDamId:(NSString *) damId
                      encoding:(NSString *) encoding
                    resolution:(NSString *) resolution
                          book:(NSString *) bookId
                       chapter:(NSNumber *) chapterId
                       success:(void (^)(NSArray *videoPaths)) success
                       failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (bookId)
        params[@"book_id"] = bookId;
    if (encoding)
        params[@"encoding"] = encoding;
    if (resolution)
        params[@"resolution"] = resolution;
    if (chapterId)
        params[@"chapter_id"] = chapterId;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathVideoPath
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *pathsArray = [@[] mutableCopy];
                                       for(NSDictionary *pathDict in response)
                                       {
                                           DBTVideoPath *p = [[DBTVideoPath alloc] initWithDictionary:pathDict];
                                           [pathsArray addObject:p];
                                       }
                                       success([NSArray arrayWithArray:pathsArray]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

#pragma mark - Library

+ (void) getLibraryVolumeLanguageWithRoot:(NSString *) root
                             languageCode:(NSString *) languageCode
                                    media:(NSString *) media
                                 success :(void (^)(NSArray *volumeLanguages)) success
                                  failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if(root)
        params[@"root"] = root;
    if (languageCode)
        params[@"language_code"] = languageCode;
    if (media)
        params[@"media"] = media;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathVolumeLanguage
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *volumeLanguages = [@[] mutableCopy];
                                       for(NSDictionary *volumeLanguageDict in response)
                                       {
                                           DBTVolumeLanguage *vl = [[DBTVolumeLanguage alloc] initWithDictionary:volumeLanguageDict];
                                           [volumeLanguages addObject:vl];
                                       }
                                       success([NSArray arrayWithArray:volumeLanguages]);
                                   } failure:^(NSError * error) {
                                       failure(error);
                                   }];
}

+ (void) getLibraryVolumeLanguageFamilyWithRoot:(NSString *) root
                                   languageCode:(NSString *) languageCode
                                          media:(NSString *) media
                                       success :(void (^)(NSArray *volumeLanguages)) success
                                        failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if(root)
        params[@"root"] = root;
    if (languageCode)
        params[@"language_code"] = languageCode;
    if (media)
        params[@"media"] = media;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathVolumeLanguageFamily
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *volumeLanguages = [@[] mutableCopy];
                                       for(NSDictionary *volumeLanguageDict in response)
                                       {
                                           DBTVolumeLanguage *vl = [[DBTVolumeLanguage alloc] initWithDictionary:volumeLanguageDict];
                                           [volumeLanguages addObject:vl];
                                       }
                                       success([NSArray arrayWithArray:volumeLanguages]);
                                   } failure:^(NSError * error) {
                                       failure(error);
                                   }];
}

+ (void) getLibraryLanguageWithRoot:(NSString *) root
                       languageCode:(NSString *) languageCode
                              media:(NSString *) media
                           success :(void (^)(NSArray *volumeLanguages)) success
                            failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if(root)
        params[@"root"] = root;
    if (languageCode)
        params[@"language_code"] = languageCode;
    if (media)
        params[@"media"] = media;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLanguage
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *volumeLanguages = [@[] mutableCopy];
                                       for(NSDictionary *volumeLanguageDict in response)
                                       {
                                           DBTVolumeLanguage *vl = [[DBTVolumeLanguage alloc] initWithDictionary:volumeLanguageDict];
                                           [volumeLanguages addObject:vl];
                                       }
                                       success([NSArray arrayWithArray:volumeLanguages]);
                                   } failure:^(NSError * error) {
                                       failure(error);
                                   }];
}

+ (void) getVolumeWithDamID:(NSString *) damId
                      languageCode:(NSString *) languageCode
                             media:(NSString *) media
                           success:(void (^)(NSArray *volumes)) success
                           failure:(DBTWebinterfaceFailureBlock) failure __deprecated {
    [DBT getLibraryVolumeWithDamID:damId
                      languageCode:languageCode
                             media:media
                           success:success
                           failure:failure];
}

+ (void) getLibraryVolumeWithDamID:(NSString *) damId
                      languageCode:(NSString *) languageCode
                             media:(NSString *) media
                           success:(void (^)(NSArray *volumes)) success
                           failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (languageCode)
        params[@"language_code"] = languageCode;
    if (media)
        params[@"media"] = media;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathVolume
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *volumes = [@[] mutableCopy];
                                       for(NSDictionary *volumeDict in response)
                                       {
                                           DBTVolume *v = [[DBTVolume alloc] initWithDictionary:volumeDict];
                                           [volumes addObject:v];
                                       }
                                       success([NSArray arrayWithArray:volumes]);
                                   } failure:^(NSError * error) {
                                       failure(error);
                                   }];
}

+ (void) getLibraryBookWithDamId:(NSString *) damId
                         success:(void (^)(NSArray *books)) success
                         failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathBook
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *books = [@[] mutableCopy];
                                       for(NSDictionary *bookDict in response)
                                       {
                                           DBTBook *b = [[DBTBook alloc] initWithDictionary:bookDict];
                                           [books addObject:b];
                                       }
                                       success([NSArray arrayWithArray:books]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getBookWithDamId:(NSString *) damId
                  success:(void (^)(NSArray *books)) success
                  failure:(DBTWebinterfaceFailureBlock) failure __deprecated {
    [DBT getLibraryBookWithDamId:damId
                         success:success
                         failure:failure];
}

+ (void) getLibraryVersionWithCode:(NSString *) code
                              name:(NSString *) name
                           success:(void (^)(NSArray *versions)) success
                           failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (code)
        params[@"code"] = code;
    if (name)
        params[@"name"] = name;

    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryVersion
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *arr = [@[] mutableCopy];
                                       for(NSDictionary *dict in response)
                                       {
                                           DBTVersion *obj = [[DBTVersion alloc] initWithDictionary:dict];
                                           [arr addObject:obj];
                                       }
                                       success([NSArray arrayWithArray:arr]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getLibraryBookOrderWithDamId:(NSString *) damId
                              success:(void (^)(NSArray *bookOrders)) success
                              failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryBookOrder
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *arr = [@[] mutableCopy];
                                       for(NSDictionary *dict in response)
                                       {
                                           DBTBookOrder *obj = [[DBTBookOrder alloc] initWithDictionary:dict];
                                           [arr addObject:obj];
                                       }
                                       success([NSArray arrayWithArray:arr]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];

}

+ (void) getLibraryBookNameWithLanguageCode:(NSString *) languageCode
                                    success:(void (^)(NSDictionary *libraryBookNames)) success
                                    failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (languageCode)
        params[@"language_code"] = languageCode;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryBookName
                                    params:params
                                   success:^(id response) {
                                       NSArray *arr = (NSArray *) response;
                                       if(arr && arr.count > 0) {
                                           success(arr[0]);
                                       } else {
                                           failure(nil);
                                       }
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];

}

+ (void) getLibraryChapterWithDamId:(NSString *) damId
                             bookId:(NSString *) bookId
                            success:(void (^)(NSArray *chapters)) success
                            failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (bookId)
        params[@"book_id"] = bookId;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryChapter
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *arr = [@[] mutableCopy];
                                       for(NSDictionary *dict in response)
                                       {
                                           DBTChapter *obj = [[DBTChapter alloc] initWithDictionary:dict];
                                           [arr addObject:obj];
                                       }
                                       success([NSArray arrayWithArray:arr]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getChapterWithDamId:(NSString *) damId
                      bookId:(NSString *) bookId
                     success:(void (^)(NSArray *chapters)) success
                     failure:(DBTWebinterfaceFailureBlock) failure __deprecated {
    [DBT getLibraryChapterWithDamId:damId
                             bookId:bookId
                            success:success
                            failure:failure];
}

+ (void) getLibraryVerseInfoWithDamId:(NSString *) damId
                               bookId:(NSString *) bookId
                            chapterId:(NSNumber *) chapterId
                           verseStart:(NSNumber *) verseStart
                             verseEnd:(NSNumber *) verseEnd
                              success:(void (^)(NSArray *verses)) success
                              failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    if (bookId)
        params[@"book_id"] = bookId;
    if (chapterId)
        params[@"chapter_id"] = chapterId;
    if (verseStart)
        params[@"verse_start"] = verseStart;
    if (verseEnd)
        params[@"verse_end"] = verseEnd;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryVerseInfo
                                    params:params
                                   success:^(id response) {
//                                       NSMutableArray *arr = [@[] mutableCopy];
//                                       for(NSDictionary *dict in response)
//                                       {
//                                           DBTChapter *obj = [[DBTChapter alloc] initWithDictionary:dict];
//                                           [arr addObject:obj];
//                                       }
//                                       success([NSArray arrayWithArray:arr]);
                                       NSLog(@"foo %@", response);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getLibraryNumbersWithLanguageCode:(NSString *) languageCode
                                     start:(NSNumber *) start
                                       end:(NSNumber *) end
                                   success:(void (^)(NSDictionary *numbers)) success
                                   failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if(languageCode)
        params[@"language_code"] = languageCode;
    if (start)
        params[@"start"] = start;
    if (end)
        params[@"end"] = end;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryNumbers
                                    params:params
                                   success:^(id response) {
                                       NSArray *arr = (NSArray *) response;
                                       if(arr && arr.count > 0) {
                                           success(arr[0]);
                                       } else {
                                           success(@{});
                                       }
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getLibraryVolumeOrganizationWithLanguageCode:(NSString *) languageCode
                                               status:(NSString *) status
                                       organizationId:(NSString *) organizationId
                                     organizationName:(NSString *) organizationName
                                              success:(void (^)(NSArray *volumeOrganizations)) success
                                              failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (languageCode)
        params[@"language_code"] = languageCode;
    if (status)
        params[@"status"] = status;
    if (organizationId)
        params[@"organization_id"] = organizationId;
    if (organizationName)
        params[@"organization_name"] = organizationName;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryVolumeOrganization
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *arr = [@[] mutableCopy];
                                       for(NSDictionary *dict in response)
                                       {
                                           DBTVolumeOrganization *obj = [[DBTVolumeOrganization alloc] initWithDictionary:dict];
                                           [arr addObject:obj];
                                       }
                                       success([NSArray arrayWithArray:arr]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

+ (void) getLibraryAssetWithDamId:(NSString *) damId
                          success:(void (^)(NSArray *assets)) success
                          failure:(DBTWebinterfaceFailureBlock) failure {
    NSMutableDictionary *params = [@{} mutableCopy];
    if (damId)
        params[@"dam_id"] = damId;
    
    [[DBTWebInterface sharedInterface] get:kDBTAPIPathLibraryAsset
                                    params:params
                                   success:^(id response) {
                                       NSMutableArray *arr = [@[] mutableCopy];
                                       for(NSDictionary *dict in response)
                                       {
                                           DBTAsset *obj = [[DBTAsset alloc] initWithDictionary:dict];
                                           [arr addObject:obj];
                                       }
                                       success([NSArray arrayWithArray:arr]);
                                   } failure:^(NSError *error) {
                                       failure(error);
                                   }];
}

@end
