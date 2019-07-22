//
//  DBTWebInterface.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//


#import <Foundation/Foundation.h>

typedef void (^DBTWebInterfaceResponseBlock)(id response);
typedef void (^DBTWebinterfaceFailureBlock)(NSError *error);

@interface DBTWebInterface : NSObject
@property(nonatomic, strong) NSString *apiKey;
+ (id) sharedInterface;

// Web methods
- (void) get:(NSString *) path
      params:(NSDictionary *) params
     success:(DBTWebInterfaceResponseBlock) success
     failure:(DBTWebinterfaceFailureBlock) failure;

@end