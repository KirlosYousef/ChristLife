//
//  DBTObject.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTObject.h"
#import <objc/runtime.h>

@implementation DBTObject

- (id) initWithDictionary:(NSDictionary *) dict {
    self = [super init];
    if(self) {
        
    }
    return self;
}

- (NSString *) description
{
    uint count;
    objc_property_t* properties = class_copyPropertyList(self.class, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    NSString *returnString = @"";
    for(NSString *key in propertyArray)
    {
        id value = [self valueForKey:key];
        returnString = [returnString stringByAppendingFormat:@"%@: %@\r",key, value];
    }
    
    return returnString;
}


@end
