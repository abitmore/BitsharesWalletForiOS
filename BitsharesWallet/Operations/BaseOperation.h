//
//  BaseOperation.h
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectToDataProtocol.h"
@class PublicKey;

@interface BaseOperation : NSObject<ObjectToDataProtocol>

/**
 操作所需的签名公钥
 */
@property (nonatomic, strong, readonly) NSArray <PublicKey *> *requiredAuthority;


@end