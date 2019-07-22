//
//  DBTBookOrder
//  Pods
//
//  Created by Brandon Trebitowski on 9/7/14.
//
//

#import "DBTObject.h"

@interface DBTBookOrder : DBTObject
@property(nonatomic, strong) NSNumber *bookOrder;
@property(nonatomic, strong) NSString *bookId;
@property(nonatomic, strong) NSString *bookName;
@property(nonatomic, strong) NSString *damIdRoot;
@end
