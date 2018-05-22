//
//  VSBasePacket.m
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBasePacket.h"

@implementation VSBasePacket

- (void)dealloc
{
#if NS_BLOCKS_AVAILABLE
    [self releaseBlocksOnMainThread];
#endif
    
}

+ (VSBasePacket*)createPacketUrl:(NSString*)apiUrl parm:(id)parm callBack:(VSMessageHandleCallBack)callBack
{
    VSBasePacket *packet = [[[self class] alloc]init];
    
    packet.apiUrl        = apiUrl;
    packet.packetParm    = parm;
    packet.completeBlock = callBack;
    
    return packet;
}

- (void)cancelFromMessageCenter
{
    [self releaseBlocksOnMainThread];
    
    //TODO：从消息中心中移除
#warning ===待实现
}

- (void)releaseBlocksOnMainThread
{
    NSMutableArray *blocks = [NSMutableArray array];
    if (_completeBlock)
    {
        [blocks addObject:_completeBlock];
        _completeBlock = nil;
    }
    
    [[self class] performSelectorOnMainThread:@selector(releaseSelfBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
}

+ (void)releaseSelfBlocks:(NSArray*)blocks
{
}

@end
