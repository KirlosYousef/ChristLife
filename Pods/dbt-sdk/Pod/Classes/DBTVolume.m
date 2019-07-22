//
//  DBTVolume.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTVolume.h"

@implementation DBTVolume
- (id) initWithDictionary:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
        f1.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        
        self.audioZipPath = dict[@"audio_zip_path"];
        self.collectionCode = dict[@"collection_code"];
        self.collectionName = dict[@"collection_name"];
        self.createdOn =[f1 dateFromString:dict[@"created_on"]];
        self.damId = dict[@"dam_id"];
        self.dbpAgreement = [NSNumber numberWithBool:[dict[@"dbp_agreement"] boolValue]];
        self.delivery = dict[@"delivery"];
        self.expiration =[f1 dateFromString:dict[@"expiration"]];
        self.fcbhId = dict[@"fcbh_id"];
        self.font = dict[@"font"];
        
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
        self.mediaType = dict[@"media_type"];
        self.numArt = dict[@"num_art"];
        self.numSampleAudio = dict[@"num_sample_audio"];
        self.resolution = dict[@"resolution"];
        self.rightToLeft = [NSNumber numberWithBool: [dict[@"right_to_left"] boolValue] ];
        self.sku = dict[@"sku"];
        self.status = dict[@"status"];
        self.updatedOn = [f1 dateFromString: dict[@"updated_on"]];
        self.versionCode = dict[@"version_code"];
        self.versionEnglish = dict[@"version_english"];
        self.versionName = dict[@"version_name"];
        self.volumeName = dict[@"volume_name"];
        
    }
    return self;
}
@end
