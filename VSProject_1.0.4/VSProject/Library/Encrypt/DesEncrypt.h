//
//  DesEncrypt.h
//  Scan
//
//  Created by zhangtie on 13-11-24.
//
//

#import <Foundation/Foundation.h>



#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>




@interface DesEncrypt : NSObject {
    
}

+ (NSString *) md5:(NSString *)str;
+ (NSString *) doCipher:(NSString *)sTextIn key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt;
+ (NSString *) encryptStr:(NSString *) str;
+ (NSString *) decryptStr:(NSString *) str;

+ (NSString *) encryptUseDES:(NSString *)plainText andKey:(NSString*)key;
+(NSString *)decryptUseDES:(NSString *)cipherText;

#pragma mark Based64
+ (NSString *) encodeBase64WithString:(NSString *)strData;
+ (NSString *) encodeBase64WithData:(NSData *)objData;
+ (NSData *) decodeBase64WithString:(NSString *)strBase64;


@end
