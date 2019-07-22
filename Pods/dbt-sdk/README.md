# dbt-sdk

## Installation

dbt-sdk is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following lines to your Podfile:

```
pod 'dbt-sdk', '~> 0.1'
```

## Usage

Below are the steps necessary to get you started with the DBT SDK.

### 1. Sign up for an API Key

Before you can start using the DBT SDK, you will need to sign up for an API Key at [https://www.digitalbibleplatform.com](https://www.digitalbibleplatform.com).  

### 2. Import the header files

In your AppDelegate.m file import the following files

```

#import <dbt-sdk/dbt.h> 
	
```

### 3. Set your API key

Inside of the application:didFinishLaunching:withOptions: method, add the following code.  Make sure to replace API_KEY with the API key you were assigned for DBT.

```

[DBT setAPIKey:@"API_KEY"];

```

### 4. Common Flow For Verse Text

There are quite a few methods available, however there is a common flow that most applications will use in order to fetch the text content they need.  Here are the steps:

1. Get the volume listing
2. Get the books for a given volume
3. Get the chapters for a given book
4. Get the verses for a given chapter

Here is a sample flow to get you started:

#### Volume Listing

This method lists all of the available volumes for the given parameters.  The media parameter can either be "text", "audio", or "video" depending on what type of content you are interested in retrieving. 

```

[DBT getVolumeWithDamID:nil
           languageCode:@"ENG"
                  media:@"text"
                success:^(NSArray *volumes) {
                    NSLog(@"Volumes %@", volumes);
                } failure:^(NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
					
```

This will return an array of DBTVolume objects.  These volume objects have one important field that will be used on all subsequent calls. It's called **damId** which is used to identify which volume you are using.

#### Books Listing

Once you have a damId, you can then use it to fetch the array of DBTBook objects.

```

[DBT getBookWithDamId:@"ENGESVN2ET"
              success:^(NSArray *books) {
                  NSLog(@"Books: %@", books);
              } failure:^(NSError *error) {
                  NSLog(@"Error: %@", error);
              }];				  
				  
```

#### Verse Listing

Finally, you will need to get the verses for a given chapter. This method can be used to get a single verse, or any number of verses. Note: passing nil for both verseStart and verseEnd will retrieve every verse.

```

[DBT getVerseWithDamId:@"ENGESVN2ET"
                      book:@"John"
                   chapter:@3
                verseStart:nil
                  verseEnd:nil
                   success:^(NSArray *verses) {
                       NSLog(@"Verses: %@", verses);
                   } failure:^(NSError *error) {
                       NSLog(@"Error: %@", error);
                   }];
	
``` 

#### Audio Playback

If you selected a volume that supports audio (by setting media to audio in the getLibraryVolumeWithDamId: call), then there are a few things you need to know in order to play back the audio.  Two objects are required in order to build the endpoint for audio playback.  They are a DBTMediaLocation object and a DBTAudioPath object.   Below is a sample set of nested API calls that will generate a full audio path for you.

```

// Imports
#import <dbt-sdk/DBTMediaLocation.h>
#import <dbt-sdk/DBTAudioPath.h>

[DBT getAudioLocation:@"http"
              success:^(NSArray *audioLocations) {
                  if(audioLocations.count) {
                      DBTMediaLocation *location = audioLocations[0];
                      [DBT getAudioPathWithDamId:@"ENGCEVO2DA"
                                            book:@"Gen"
                                         chapter:@1
                                         success:^(NSArray *audioPaths) {
                                             if(audioPaths.count) {
                                                 DBTAudioPath *audioPath = audioPaths[0];
                                                 NSString *urlString = [NSString stringWithFormat:@"%@/%@",location.baseURL,audioPath.path];
                                                 NSURL *url = [NSURL URLWithString:urlString];
                                                 NSLog(@"Audio file URL: %@", url);
                                             }
                                         } failure:^(NSError *error) {
                                             NSLog(@"Audio Path Error: %@", error);
                                         }];
                  }
              } failure:^(NSError *error) {
                  NSLog(@"Audio Location Error: %@", error);
              }];
```				

Once you have the url to the audio file, it can be played using the standard iOS audio playback libraries.  

#### Other/Unimplemented DBT API Calls

The SDK is fairly comprehensive in terms of what API calls are covered. However, if you find a call in the DBT that is not implemented in the SDK, you can always revert to using our generic API method.  It takes an endpoint and an NSDictionary of key values for parameters.   The only caveat is, the response will be an NSDictionary or NSArray containing the data returned from the API.  Here is an example of using it to call:

```

[DBT query:@"/text/font"
    params:@{@"id" : @1}
   success:^(id results) {
       NSLog(@"Font: %@", results);
   } failure:^(NSError *error) {
       NSLog(@"Error: %@", error);
   }];
   
```

This will return an array of NSDictionaries that contain information about a font with id 1.

## Author

Brandon Trebitowski, brandontreb@gmail.com

## License

dbt-sdk is available under the MIT license. See the LICENSE file for more info.