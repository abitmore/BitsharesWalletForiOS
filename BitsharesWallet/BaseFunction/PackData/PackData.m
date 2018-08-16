//
//  PackData.m
//  BitsharesWallet
//
//  Created by flh on 2018/8/15.
//  Copyright © 2018年 flh. All rights reserved.
//

#import "PackData.h"

@implementation PackData

+ (NSData *)packShort:(short)value {
    Byte byte[2] = {0};
    
    for (int i = 0; i < 2; i ++) {
        byte[i] = (Byte) ((value >> (i * 8)) & 0xff);
    }
    
    return [NSData dataWithBytes:byte length:2];
}

+ (NSData *)packInt:(int)value {
    Byte byte[4] = {0};
    
    for (int i = 0; i < 4; i ++) {
        byte[i] = (Byte) ((value >> (i * 8)) & 0xff);
    }
    
    return [NSData dataWithBytes:byte length:4];
}

+ (NSData *)packUnsigedInteger:(NSInteger)value {
    NSMutableData *data = [NSMutableData dataWithCapacity:20];
    
    do {
        Byte b = (Byte)(value & 0x7f);
        
        value >>= 7;
        
        if (value > 0) {
            b |= (1 << 7);
        }
        
        [data appendBytes:&b length:1];
    } while (value > 0);
    
    return [data copy];
}

+ (NSData *)packLongValue:(long)value {
    Byte *bytes = (Byte *)malloc(8);
    
    for (int i = 0; i < 8; i ++) {
        bytes[i] = (Byte)((value >> (i * 8)) & 0xff);
    }
    
    NSData *totalData = [NSData dataWithBytes:bytes length:8];
    
    free(bytes);
    
    return totalData;
}

+ (NSData *)packUInt64_T:(uint64_t)value {
    uint64_t val = value;
    NSMutableData *data = [NSMutableData dataWithCapacity:8];
    
    do {
        uint8_t b = val & 0x7f;
        val >>= 7;
        b |= ((val > 0) << 7);
        [data appendBytes:&b length:1];
    }while( val );
    
    return [data copy];
}

+ (NSData *)packBool:(BOOL)boolValue {
    Byte byte = boolValue?1:0;
    
    NSData *data = [NSData dataWithBytes:&byte length:1];
    
    return data;
}

+ (NSData *)packDate:(NSDate *)date {
    NSInteger timeInterval = [date timeIntervalSince1970];
    
    Byte *byte = (Byte *)malloc(4);
    
    for (int i = 0; i < 4; i ++) {
        byte[i] = (Byte) ((timeInterval >> (i * 8)) & 0xff);
    }
    
    NSData *data = [NSData dataWithBytes:byte length:4];
    
    free(byte);
    
    return data;
}

@end
