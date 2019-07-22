//
//  DBTVolume.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTObject.h"

@interface DBTVolume : DBTObject

@property(nonatomic, strong) NSString *audioZipPath;
@property(nonatomic, strong) NSString *collectionCode;
@property(nonatomic, strong) NSString *collectionName;
@property(nonatomic, strong) NSDate *createdOn;
@property(nonatomic, strong) NSString *damId;
@property(nonatomic, strong) NSNumber *dbpAgreement;
@property(nonatomic, strong) NSArray *delivery;
@property(nonatomic, strong) NSDate *expiration;
@property(nonatomic, strong) NSString *fcbhId;
@property(nonatomic, strong) NSString *font;
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
@property(nonatomic, strong) NSString *media;
@property(nonatomic, strong) NSString *mediaType;
@property(nonatomic, strong) NSNumber *numArt;
@property(nonatomic, strong) NSNumber *numSampleAudio;
@property(nonatomic, strong) NSArray *resolution;
@property(nonatomic, strong) NSNumber *rightToLeft;
@property(nonatomic, strong) NSString *sku;
@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSDate *updatedOn;
@property(nonatomic, strong) NSString *versionCode;
@property(nonatomic, strong) NSString *versionEnglish;
@property(nonatomic, strong) NSString *versionName;
@property(nonatomic, strong) NSString *volumeName;

- (id) initWithDictionary:(NSDictionary *) dict;

@end
