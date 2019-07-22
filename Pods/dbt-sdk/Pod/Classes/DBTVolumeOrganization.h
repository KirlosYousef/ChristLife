//
//  DBTVolumeOrganization.h
//  Pods
//
//  Created by Brandon Trebitowski on 9/8/14.
//
//

#import "DBTObject.h"

@interface DBTVolumeOrganization : DBTObject
@property(nonatomic, strong) NSNumber *numberVolumes;
@property(nonatomic, strong) NSString *organizationName;
@property(nonatomic, strong) NSNumber *organizationId;
@end
