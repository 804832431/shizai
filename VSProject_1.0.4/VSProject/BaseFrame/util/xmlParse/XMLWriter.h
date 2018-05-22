//
//  XMLWriter.h
//  VSProject
//
//  Created by tiezhang on 15/2/16.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLNodeItem : NSObject {
    NSString* itemName;
    NSDictionary* attributeDic;
    NSMutableArray* subItems;
}
@property(nonatomic, copy)NSString* itemName;
@property(nonatomic, strong)NSDictionary* attributeDic;
@property(nonatomic, strong)NSMutableArray* subItems;

@end

@interface XMLWriter : NSObject

+(void)toXmlStringForXMLNodeItem:(XMLNodeItem*)item desString:(NSMutableString**)desStr;

@end
