//
//  DBTVolumeLanguage.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTVolumeLanguage.h"

@implementation DBTVolumeLanguage

- (id) initWithDictionary:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.delivery = dict[@"delivery"];
        self.englishName = dict[@"english_name"];
        self.languageCode = dict[@"language_code"];
        self.languageFamilyCode = dict[@"language_family_code"];
        self.languageFamilyEnglish = dict[@"language_family_english"];
        self.languageFamilyIso = dict[@"language_family_iso"];
        self.languageFamilyIso1 = dict[@"language_family_iso_1"];
        self.languageFamilyIso2B = dict[@"language_family_iso_2B"];
        self.languageFamilyIso2T = dict[@"language_family_iso_2T"];
        self.languageFamilyName = dict[@"language_family_name"];
        self.languageIso = dict[@"language_iso"];
        self.languageIso1 = dict[@"language_iso_1"];
        self.languageIso2B = dict[@"language_iso_2B"];
        self.languageIso2T = dict[@"language_iso_2T"];
        self.languageIsoName = dict[@"language_iso_name"];
        self.languageName = dict[@"language_name"];
        self.media = dict[@"media"];
        self.resolution = dict[@"resolution"];
        self.language = dict[@"language"];
    }
    return self;
}

@end
