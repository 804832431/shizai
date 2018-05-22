//
//  GreatActivityDetailView.m
//  VSProject
//
//  Created by certus on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "GreatActivityDetailView.h"
#import <CoreText/CoreText.h>

@implementation GreatActivityDetailView


- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0, -30, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"iOS程序在启动时会创建一个主线程，而在一个线程只能执行一件事情，如果在主线程执行某些耗时操作，例如加载网络图片，下载资源文件等会阻塞主线程（导致界面卡死，无法交互），所以就需要使用多线程技术来避免这类情况。iOS中有三种多线程技术 NSThread，NSOperation，GCD，这三种技术是随着IOS发展引入的，抽象层次由低到高，使用也越来越简单。"];

    [attrString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(10, 10)];
    
    CGFloat fontsize = 20;
    CTFontRef fontref = CTFontCreateWithName((CFStringRef)@"ArialMT", fontsize, NULL);
    [attrString addAttribute:(id)kCTFontAttributeName value:(__bridge id _Nonnull)(fontref) range:NSMakeRange(15, 10)];
    CFRelease(fontref);
    
    CGFloat lineSpacing = 10;
    const CFIndex KnumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[KnumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpacing}
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, KnumberOfSettings);
    [attrString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id _Nonnull)theParagraphRef range:NSMakeRange(0, attrString.length)];
    CFRelease(theParagraphRef);

    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;

    NSDictionary *imgInfoDic = @{@"width":@100,@"height":@30};
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)imgInfoDic);
    
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc]initWithString:content];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    
    [attrString insertAttributedString:space atIndex:50];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attrString.length), path, NULL);
    CTFrameDraw(frame, context);
    
    UIImage *image = [UIImage imageNamed:@"act_head"];
    CGContextDrawImage(context, [self calculateImagePositionInCTFrame:frame], image.CGImage);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

#pragma mark - CTRun delegate 回调方法

static CGFloat ascentCallback(void *ref){

    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref){
    
    return 0;
}

static CGFloat widthCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}

- (CGRect)calculateImagePositionInCTFrame:(CTFrameRef)ctFrame {

    NSArray *lines = (NSArray *)CTFrameGetLines(ctFrame);
    NSInteger linecount = [lines count];
    CGPoint lineOrigins[linecount];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    for (NSInteger i = 0; i < linecount; i++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray *runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        
        for (id runObj in runObjArray) {
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes objectForKey:(id)kCTRunDelegateAttributeName];
            if (!delegate) {
                continue;
            }
            NSDictionary *metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGRect runBounds;
            
            
            CGPathRef pathRef = CTFrameGetPath(ctFrame);
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            
            runBounds.size.width = colRect.size.width;
            runBounds.size.height = 183;
            runBounds.origin.x = 0;
            runBounds.origin.y = 0;

            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            return delegateBounds;
            
        }
    }
    return CGRectZero;
}

@end