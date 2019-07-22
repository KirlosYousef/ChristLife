//
//  DBT.h
//  Pods
//
//  Created by Brandon Trebitowski on 8/19/14.
//
//

#import <Foundation/Foundation.h>
#import "DBTWebInterface.h"

// Models
#import "DBTAudioPath.h"
#import "DBTBook.h"
#import "DBTMediaLocation.h"
#import "DBTVerse.h"
#import "DBTVideoPath.h"
#import "DBTVolumeLanguage.h"
#import "DBTVolume.h"
#import "DBTAsset.h"

@interface DBT : NSObject

/**
 * Sets your API key in order to authenticate the other calls.  This call must
 * be made bfore any other call to access the DBT.  
 *
 * You can sign up for a key at the following URL:
 *
 * <a href="https://www.digitalbibleplatform.com">https://www.digitalbibleplatform.com</a>
 *
 * @params apiKey This is the API key you received from DBT
 *
 */
+ (void) setAPIKey:(NSString *) apiKey;

/**
 * This method allows you to call any API method in the DBT. The
 * documentation for the paths and parameters can be found at the
 * following URL:
 *
 * <a href="https://www.digitalbibleplatform.com/docs/api-version-2/api/">
 * https://www.digitalbibleplatform.com/docs/api-version-2/api/
 * </a>
 *
 * @params path The API endpoint you want to call prefixed with a forward slash. 
 * an example of what to pass in for this parameter is @"/text/verse".
 *
 * @params params This is a dictionary containing the inputs for the API call. They
 * are case sensitive and must adhere to the spec at the URL above.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * a results parameter which contains either a dictionary or array of dictionaries containing the parsed
 * response of the API call.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for 
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) query:(NSString *)path
        params:(NSDictionary *) params
      success :(void (^)(id results)) success
       failure:(DBTWebinterfaceFailureBlock) failure;

#pragma mark - Text API Calls

/**
 * This method retrieves the bible verse text for the specified volume/book/chapter. 
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-text/verse/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-text/verse/
 * </a>
 *
 * @params damId (optional): the volume internal DAM ID. Can be used to restrict the response
 * to only DAM IDs that contain with 'N2' for example
 *
 * @params bookId (optional): If specified returns verse text ONLY for the specified book.
 *
 * @params chapter (optional): If specified returns verse text ONLY for the specified book and chapter.
 *
 * @params verseStart  (optional): If specified without 'verse_end' returns verse text ONLY 
 * for the specified book, chapter, and verse. If specified with 'verse_end' returns all 
 * verse text for the specified book, chapter, and verse range from 'verse_start' to 'verse_end'.
 *
 * @params verseEnd (optional): If specified returns of all verse text for the specified book, 
 * chapter, and verse range from 'verse_start' to 'verse_end'. If specified requires that 'verse' is 
 * also specified.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVerse objects that match the query.
 *
 * @params failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getTextVerseWithDamId:(NSString *) damId
                          book:(NSString *) bookId
                       chapter:(NSNumber *) chapterId
                    verseStart:(NSNumber *) verseStart
                      verseEnd:(NSNumber *) verseEnd
                       success:(void (^)(NSArray *verses)) success
                       failure:(DBTWebinterfaceFailureBlock) failure;

+ (void) getVerseWithDamId:(NSString *) damId
                          book:(NSString *) bookId
                       chapter:(NSNumber *) chapterId
                    verseStart:(NSNumber *) verseStart
                      verseEnd:(NSNumber *) verseEnd
                       success:(void (^)(NSArray *verses)) success
                       failure:(DBTWebinterfaceFailureBlock) failure __deprecated;

/**
 * This method retrieves the list of available books for a specified volume or OT/NT volume
 * set, if they exist. The documentation for the paths and parameters can be
 * found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-text/search/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-text/search/
 * </a>
 *
 * @params damId (optional): the volume internal DAM ID. Can be used to restrict the response
 * to only DAM IDs that contain with 'N2' for example
 *
 * @params query The text that the caller wishes to search for in the specified text. Multiple 
 * words or phrases can be combined with '+' for AND and '|' for OR. They will be processed 
 * simply from left to right. So, "Saul+Paul|Ruth" will evaluate as (Saul AND Paul) OR Ruth.
 *
 * @params bookId (optional): If specified returns verse text ONLY for the specified book.
 *
 * @params offset (optional): The offset for the set of results to return. Default is 0.
 *
 * @params limit (optional): The number of results to return. Default is 50.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVerse objects that match the query.
 *
 * @params failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) searchTextWithDamId:(NSString *) damId
                       query:(NSString *) query
                        book:(NSString *) bookId
                      offset:(NSNumber *) offset
                       limit:(NSNumber *) limit
                     success:(void (^)(NSArray *verses, NSInteger totalResults)) success
                     failure:(DBTWebinterfaceFailureBlock) failure;

#pragma mark - Audio API Calls

/**
 * This method allows the caller to retrieve information about the media distribution 
 * servers and protocols they support. The documentation for
 * the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-audio/location/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-audio/location/
 * </a>
 *
 * @params protocol Allows the caller to restrict potential servers from being returned that 
 * don't support a specified protocol. Examples: http, https, rtmp, rtmp-amazon
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTMediaLocation objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getAudioLocation:(NSString *) protocol
                  success:(void (^)(NSArray *audioLocations)) success
                  failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This call returns the file path information for audio files for a volume. This 
 * information can be used with the response of the @getAudioLocation:success:failure: call to create
 * a URI to retrieve the audio files. The documentation for the paths and parameters 
 * can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-audio/path/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-audio/path/
 * </a>
 *
 * @params damId The DAM ID for which to retrieve file path info.
 *
 * @params bookId (optional): The OSIS id of the book. If book is not specified ALL book/chapter 
 * information for the given language is returned to the caller. Otherwise chapter information for 
 * the specified book is returned.
 *
 * @params chapterId (optional): The id for the specified chapter. If chapter is specified only 
 * the specified chapter audio information is returned to the caller.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTAudioPath objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getAudioPathWithDamId:(NSString *) damId
                          book:(NSString *) bookId
                       chapter:(NSNumber *) chapterId
                       success:(void (^)(NSArray *audioPaths)) success
                       failure:(DBTWebinterfaceFailureBlock) failure;


/**
 * This method provides the bible audio verse time starts for the specified volume/book/chapter.
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-audio/verse-audio-timecodes-list/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-audio/verse-audio-timecodes-list/
 * </a>
 *
 * Note: This call currently only supports the following damIds
 * VIEVOVN2DA (Vietnamese -  Old Version New Testament)
 * SPNBDANN2DA (Spanish - 2010 Biblia de América)
 * ENGESVO2DA  (English – ESV Old Testament)
 * ENGESVN2DA (English – ESV New Testament)
 * INZNTVN2DA (Indonesian -  New Translation (formal) Version, 1974 New Testament)
 * CHNUNVN2DA (Chinese Mandarin - Union Version (Traditional) New Testament)
 *
 * @params damId the DAM ID of the audio volume
 *
 * @params bookId the book for verse times desired.
 *
 * @params chapterId the chapter for the verse times desired.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTAudioVerseStart objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.

 */
+ (void) getAudioVerseStartWithDamId:(NSString *) damId
                                book:(NSString *) bookId
                             chapter:(NSNumber *) chapterId
                             success:(void (^)(NSArray *audioVerseStarts)) success
                             failure:(DBTWebinterfaceFailureBlock) failure;


#pragma mark - Video API Calls

/**
 * This method allows the caller to retrieve information about the media distribution servers 
 * and protocols they support. The documentation for the paths and parameters can be found at 
 * the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-video/video-location/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-video/video-location/
 * </a>
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTMediaLocation objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getVideoLocationWithSuccess:(void (^)(NSArray *videoLocations)) success
                             failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This call returns the file path information for video files for a volume. This call is 
 * capable of retrieving the deaf Bible story videos provided by DOOR International. These 
 * videos contain multiple parts:
 *
 * <ul>
 *  <li>Topic – A very brief video signing the name of the file.</li>
 *  <li>Introduction – Introduces signs that are specific to this story.</li>
 *  <li>Story – The main story content.</li>
 *  <li>More Information – Additional teaching or application of the story.</li>
 * </ul>
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-video/video-path/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-video/video-path/
 * </a>
 *
 * @params damId The DAM ID for which to retrieve file path info.
 *
 * @params encoding [mp4|m3u8] The video encoding format desired.
 *
 * @params bookId (optional): The OSIS id of the book. If book is not specified ALL book/chapter
 * information for the given language is returned to the caller. Otherwise chapter information for
 * the specified book is returned.
 *
 * @params chapterId (optional): The id for the specified chapter. If chapter is specified only
 * the specified chapter audio information is returned to the caller.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVideoPath objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getVideoPathWithDamId:(NSString *) damId
                      encoding:(NSString *) encoding
                    resolution:(NSString *) resolution
                          book:(NSString *) bookId
                       chapter:(NSNumber *) chapterId
                       success:(void (^)(NSArray *videoPaths)) success
                       failure:(DBTWebinterfaceFailureBlock) failure;

#pragma mark - Library

/**
 * This method retrieves the list of languages for available volumes and the related
 * volume data in the system according to the filter specified. The documentation for
 * the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-language-list/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-language-list/
 * </a>
 *
 * @params root (optional): the native language or English language language name root.
 * Can be used to restrict the response to only languages that start with 'Quechua' for example
 *
 * @params languageCode (optional): the three letter language code.
 *
 * @params media (optional): [text|audio|video] - the format of languages the caller is interested
 * in. This specifies if you want languages available in text or languages available in audio.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVolumeLanguage objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryVolumeLanguageWithRoot:(NSString *) root
                             languageCode:(NSString *) languageCode
                                    media:(NSString *) media
                                 success :(void (^)(NSArray *volumeLanguages)) success
                                  failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This method retrieves the list of language families for available volumes and the related volume
 * data in the system according to the filter specified. The documentation for
 * the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-language-family-list/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-language-family-list/
 * </a>
 *
 * @params root (optional): the native language or English language language name root.
 * Can be used to restrict the response to only languages that start with 'Quechua' for example
 *
 * @params languageCode (optional): the three letter language code.
 *
 * @params media (optional): [text|audio|video] - the format of languages the caller is interested
 * in. This specifies if you want languages available in text or languages available in audio.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVolumeLanguage objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryVolumeLanguageFamilyWithRoot:(NSString *) root
                                   languageCode:(NSString *) languageCode
                                          media:(NSString *) media
                                       success :(void (^)(NSArray *volumeLanguages)) success
                                        failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This method retrieves the list of  languages defined in the system according to the filter 
 * specified. If the possibilities parameter is ignored, the list will be of defined DBP languages 
 * that meet all of the criteria. If the possibilities parameter is used and set to true, the list 
 * will be of defined DBP languages and ISO languages not defined in DBP that meet any of the criteria. 
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/language-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/language-listing/
 * </a>
 *
 * @params root (optional): the native language or English language language name root.
 * Can be used to restrict the response to only languages that start with 'Quechua' for example
 *
 * @params languageCode (optional): the three letter language code.
 *
 * @params media (optional): [text|audio|video] - the format of languages the caller is interested
 * in. This specifies if you want languages available in text or languages available in audio.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVolumeLanguage objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryLanguageWithRoot:(NSString *) root
                       languageCode:(NSString *) languageCode
                              media:(NSString *) media
                           success :(void (^)(NSArray *volumeLanguages)) success
                            failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This method retrieves the list of available volumes in the system according to
 * the filter specified. The documentation for the paths and parameters can be
 * found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-listing/
 * </a>
 *
 * @params damId (optional): the volume internal DAM ID. Can be used to restrict the response
 * to only DAM IDs that contain with 'N2' for example
 *
 * @params languageCode (optional): the three letter language code.
 *
 * @params media (optional): [text|audio|video] - the format of languages the caller is interested
 * in. This specifies if you want languages available in text or languages available in audio.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVolume objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryVolumeWithDamID:(NSString *) damId
                      languageCode:(NSString *) languageCode
                             media:(NSString *) media
                           success:(void (^)(NSArray *volumes)) success
                           failure:(DBTWebinterfaceFailureBlock) failure;

+ (void) getVolumeWithDamID:(NSString *) damId
                      languageCode:(NSString *) languageCode
                             media:(NSString *) media
                           success:(void (^)(NSArray *volumes)) success
                           failure:(DBTWebinterfaceFailureBlock) failure __deprecated;

/**
 * This method retrieves the list of available books for a specified volume or OT/NT volume
 * set, if they exist. The documentation for the paths and parameters can be
 * found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/book-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/book-listing/
 * </a>
 *
 * @params damId (optional): the volume internal DAM ID. Can be used to restrict the response
 * to only DAM IDs that contain with 'N2' for example
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTBook objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryBookWithDamId:(NSString *) damId
                         success:(void (^)(NSArray *books)) success
                         failure:(DBTWebinterfaceFailureBlock) failure;

+ (void) getBookWithDamId:(NSString *) damId
                         success:(void (^)(NSArray *books)) success
                         failure:(DBTWebinterfaceFailureBlock) failure __deprecated;

/**
 * Get the list of versions defined in the system.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/version-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/version-listing/
 * </a>
 *
 * @params code (optional): Get the entry for a three letter version code.
 *
 * @params (optional): Get the entry for a part of a version name in either native language or English.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVersion objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryVersionWithCode:(NSString *) code
                              name:(NSString *) name
                           success:(void (^)(NSArray *versions)) success
                           failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * Gets the book order and code listing for a volume.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/book-order-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/book-order-listing/
 * </a>
 *
 * @params damId The DAM ID of the volume. If only six characters of a DAM ID are used, this call will try 
 * to return the matching OT and NT book list, if available.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTBookOrder objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryBookOrderWithDamId:(NSString *) damId
                              success:(void (^)(NSArray *bookOrders)) success
                              failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This call retrieves the native language book names for a DBP language code.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/book-name-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/book-name-listing/
 * </a>
 *
 * @params damId The DAM ID of the volume. If only six characters of a DAM ID are used, this call will 
 * try to return the matching OT and NT book list, if available.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an NSDictionary containging the book mappings
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryBookNameWithLanguageCode:(NSString *) languageCode
                                    success:(void (^)(NSDictionary *libraryBookNames)) success
                                    failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * Lists the chapters for a book or all books in a standard bible volume. Story volumes in DBP are defined 
 * in the same top down fashion as standard bibles. So the first partitioning is into books, which correspond 
 * to the segments of audio or video. So story volumes have no chapters.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/chapter-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/chapter-listing/
 * </a>
 *
 * @params damId The DAM ID of the volume. If only six characters of a DAM ID are used, this call will try to 
 * return the matching OT and NT book list, if available.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTChapter objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryChapterWithDamId:(NSString *) damId
                             bookId:(NSString *) bookId
                            success:(void (^)(NSArray *chapters)) success
                            failure:(DBTWebinterfaceFailureBlock) failure;

+ (void) getChapterWithDamId:(NSString *) damId
                      bookId:(NSString *) bookId
                     success:(void (^)(NSArray *chapters)) success
                     failure:(DBTWebinterfaceFailureBlock) failure __deprecated;

/**
 * This method retrieves the bible verse info for the specified volume/book/chapter.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/verse-info-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/verse-info-listing/
 * </a>
 *
 * @params damId The DAM ID of the volume. If only six characters of a DAM ID are used, this call will try to
 * return the matching OT and NT book list, if available.
 *
 * @params bookId (optional): If specified returns verse text ONLY for the specified book.
 *
 * @params chapterId (optional): If specified returns verse text ONLY for the specified book and chapter.
 *
 * @params verseStart (optional): If specified without 'verse_end' returns verse text ONLY for the 
 * specified book, chapter, and verse. If specified with 'verse_end' returns all verse text for the 
 * specified book, chapter, and verse range from 'verse_start' to 'verse_end'.
 *
 * @params verseEnd (optional): If specified returns of all verse text for the specified book, chapter, 
 * and verse range from 'verse_start' to 'verse_end'. If specified requires that 'verse' is also specified.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVerse objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryVerseInfoWithDamId:(NSString *) damId
                             bookId:(NSString *) bookId
                            chapterId:(NSNumber *) chapterId
                           verseStart:(NSNumber *) verseStart
                             verseEnd:(NSNumber *) verseEnd
                            success:(void (^)(NSArray *verses)) success
                            failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This call is used to get native language numerals. Native language written numbers are 
 * useful for chapters and verses. The numerals from 0 to 200 are available. The requested 
 * numbers will be returned for a valid language code in the native language if the 
 * language_numbers record exists, or in English if not. Non-defined language codes return 
 * nothing.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/numbers-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/numbers-listing/
 * </a>
 *
 * @params languageCode: DBP Language code of interest.
 *
 * @params start First number (in Hindu numerals) of range desired.
 *
 * @params end Last number (in Hindu numerals) of range desired.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of NSString objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryNumbersWithLanguageCode:(NSString *) languageCode
                                     start:(NSNumber *) start
                                       end:(NSNumber *) end
                                   success:(void (^)(NSDictionary *numbers)) success
                                   failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This call provides basic volume data by organization.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-organization-listing/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-organization-listing/
 * </a>
 *
 * @params languageCode: DBP Language code of interest.
 *
 * @params status (optional): [live|disabled|incomplete|waiting_review|in_review|discontinued] Publishing status 
 * of volume. The default is 'live'.
 *
 * @params organizationId (optional): Organization id by which to filter volumes.
 *
 * @params organizationName (optional): Organization name, either native language or English, by which to filter volumes.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTVolumeOrganization objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryVolumeOrganizationWithLanguageCode:(NSString *) languageCode
                                               status:(NSString *) status
                                       organizationId:(NSString *) organizationId
                                     organizationName:(NSString *) organizationName
                                              success:(void (^)(NSArray *volumeOrganizations)) success
                                              failure:(DBTWebinterfaceFailureBlock) failure;

/**
 * This method retrieves information about the asset, such as artwork, distribution servers.
 *
 * The documentation for the paths and parameters can be found at the following URL:
 *
 * <a href="http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-asset-location/">
 * http://www.digitalbibleplatform.com/docs/api-version-2/library-catalog/volume-asset-location/
 * </a>
 *
 * @params damId: (optional): To get the location directory and asset file basename for a specific volume.
 *
 * @params success A block that will be called upon the success of the query.  The block contains
 * an array of DBTAsset objects that match the query.
 *
 * @oarams failure A block that will be called if the API call fails.  It could fail for
 * any number of reasons from no internet connection to invalid values passed in for the
 * parameters.
 *
 */
+ (void) getLibraryAssetWithDamId:(NSString *) damId
                          success:(void (^)(NSArray *assets)) success
                          failure:(DBTWebinterfaceFailureBlock) failure;


@end
