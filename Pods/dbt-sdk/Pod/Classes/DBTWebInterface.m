//
//  DBTWebInterface.m
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import "DBTWebInterface.h"
#import "DBTConstants.h"

@implementation DBTWebInterface

+ (id) sharedInterface
{
    static DBTWebInterface *sharedInterface = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInterface = [[self alloc] init];
    });
    return sharedInterface;
}

#pragma mark - Private

- (NSString *) createParamString:(NSDictionary *) params
{
    if(!params) return @"";
    if(params.count == 0) return @"";
    NSString *result = @"";
    id key;
    NSEnumerator *enumerator = [params keyEnumerator];
    while (key = [enumerator nextObject]) {
        result = [result stringByAppendingFormat:@"%@=%@&",
                  key,
                  [params objectForKey:key]];
    }
    result = [result substringToIndex:[result length] - 1];
    return [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (void) post:(NSString *) path
       params:(NSDictionary *) params
      success:(DBTWebInterfaceResponseBlock) success
      failure:(DBTWebInterfaceResponseBlock) failure
{
    [self requestWithMethod:@"POST"
                       path:path
                     params:params
                    success:success
                    failure:failure];
}

- (void) put:(NSString *) path
      params:(NSDictionary *) params
     success:(DBTWebInterfaceResponseBlock) success
     failure:(DBTWebInterfaceResponseBlock) failure
{
    [self requestWithMethod:@"PUT"
                       path:path
                     params:params
                    success:success
                    failure:failure];
}

- (void) delete:(NSString *) path
         params:(NSDictionary *) params
        success:(DBTWebInterfaceResponseBlock) success
        failure:(DBTWebInterfaceResponseBlock) failure
{
    [self requestWithMethod:@"DELETE"
                       path:path
                     params:params
                    success:success
                    failure:failure];
}

- (void) get:(NSString *) path
      params:(NSDictionary *) params
     success:(DBTWebInterfaceResponseBlock) success
     failure:(DBTWebinterfaceFailureBlock) failure
{
    if(params)
    {
        NSString *separator = @"?";
        if ([path rangeOfString:separator].location != NSNotFound) {
            separator = @"&";
        }
        path = [path stringByAppendingFormat:@"%@%@",
                separator,
                [self createParamString:params]];
    }
    [self requestWithMethod:@"GET"
                       path:path
                     params:nil
                    success:success
                    failure:failure];
}

- (void) requestWithMethod:(NSString *) method
                      path:(NSString *) path
                    params: (NSDictionary *) params
                   success:(DBTWebInterfaceResponseBlock) success
                   failure:(DBTWebInterfaceResponseBlock) failure
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",
                           kDBTAPIEndpoint,
                           path];
    urlString = [self urlStringWithAPIKey:urlString];
    NSLog(@"DBT: %@",urlString);
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration
                                         ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    id completionHandler = ^(NSData *data,
                             NSURLResponse *response,
                             NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // handle response
            if(error)
            {
                failure(error);
            }
            else
            {
                NSInteger code = [(NSHTTPURLResponse *)response statusCode];
                NSError *jsonError = nil;
                NSArray *jsonObj = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
                if(!jsonError)
                {
                    // Check for failure on the web
                    if(code != 200)
                    {
                        NSString *message = @"Unknown server error";
                        for(NSDictionary *m in jsonObj)
                        {
                            if(m[@"Error"])
                            {
                                message = [m[@"Error"] componentsJoinedByString:@","];
                                break;
                            } else if(m[@"Message"]) {
                                message = m[@"Message"];
                                break;
                            }
                        }
                        
                        NSDictionary *details = @{NSLocalizedDescriptionKey : message};
                        NSError *webError = [NSError errorWithDomain:@"DBT" code:code userInfo:details];
                        failure(webError);
                    }
                    else
                    {
                        success(jsonObj);
                    }
                }
                else
                {
                    failure(jsonError);
                }
            }
        });
        
    };
    
    if([method isEqualToString:@"POST"] ||
       [method isEqualToString:@"PUT"] ||
       [method isEqualToString:@"DELETE"])
    {
        // TODO Post
    }
    else
    {
        [[session dataTaskWithURL:[NSURL URLWithString:urlString]
                completionHandler:completionHandler] resume];
    }
}

- (NSString *) urlStringWithAPIKey:(NSString *) urlString
{
    // By default, append the API key to the query string
    NSString *separator = @"&";
    // Append the API key if there are no params in the query string
    if([urlString rangeOfString:@"?"].location == NSNotFound)
        separator = @"?";
    // Automatically add the DBT version number
    return [urlString stringByAppendingFormat:@"&key=%@&v=%@",self.apiKey, kDBTVerionNumber];
}

@end

