//
//  XMLWriter.m
//  VSProject
//
//  Created by tiezhang on 15/2/16.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "XMLWriter.h"


#pragma mark XMLNodeItem
@implementation XMLNodeItem

@synthesize attributeDic, subItems, itemName;

-(id)init
{
    self = [super init];
    if(self)
    {
        itemName     = nil;
        subItems     = [[NSMutableArray alloc]initWithCapacity:0];
        attributeDic = nil;
    }
    return self;
}

@end

@implementation XMLWriter

/*
 *描述:   用于将节点对象转成xml格式字符串
 *参数:   XMLNodeItem* item为将要转换的节点对象
 *       NSMutableString** desStr为最终生成的字符串地址
 */
+(void)toXmlStringForXMLNodeItem:(XMLNodeItem*)item desString:(NSMutableString**)desStr
{
    if(nil == item || item.itemName.length <= 0)
        return ;
    if((*desStr).length <= 0)
        *desStr = [[NSMutableString alloc]initWithCapacity:0];
    [*desStr appendFormat:@"<%@", [NSString stringWithFormat:@"%@", item.itemName]];
    if(item.attributeDic != nil || [item.attributeDic count]>0)
    {//添加属性
        NSArray* _keyArray = [item.attributeDic allKeys];
        for (NSString* k in _keyArray) {
            [*desStr appendFormat:@" %@=\"%@\" ", k, [item.attributeDic objectForKey:k]];
        }
        
    }
    [*desStr appendFormat:@">"];
    if(item.subItems != nil && [item.subItems count]>0)
    {//添加子节点
        for(int i=0; i<[item.subItems count]; ++i)
            [self toXmlStringForXMLNodeItem:[item.subItems objectAtIndex:i]desString:desStr];
    }
    
    [*desStr appendFormat:@"</%@>", [NSString stringWithFormat:@"%@", item.itemName]];
    NSLog(@"%@", *desStr);
}


@end
