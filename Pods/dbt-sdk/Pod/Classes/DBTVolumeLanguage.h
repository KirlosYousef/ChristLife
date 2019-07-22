//
//  DBTVolumeLanguage.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTObject.h"

@interface DBTVolumeLanguage : DBTObject

@property(nonatomic, strong) NSArray *delivery;
@property(nonatomic, strong) NSArray *media;
@property(nonatomic, strong) NSArray *resolution;
@property(nonatomic, strong) NSArray *language;
@property(nonatomic, strong) NSString *englishName;
@property(nonatomic, strong) NSString *languageCode;
@property(nonatomic, strong) NSString *languageFamilyCode;
@property(nonatomic, strong) NSString *languageFamilyEnglish;
@property(nonatomic, strong) NSString *languageFamilyIso;
@property(nonatomic, strong) NSString *languageFamilyIso1;
@property(nonatomic, strong) NSString *languageFamilyIso2B;
@property(nonatomic, strong) NSString *languageFamilyIso2T;
@property(nonatomic, strong) NSString *languageFamilyName;
@property(nonatomic, strong) NSString *languageIso;
@property(nonatomic, strong) NSString *languageIso1;
@property(nonatomic, strong) NSString *languageIso2B;
@property(nonatomic, strong) NSString *languageIso2T;
@property(nonatomic, strong) NSString *languageIsoName;
@property(nonatomic, strong) NSString *languageName;

- (id) initWithDictionary:(NSDictionary *) dict;

@end
