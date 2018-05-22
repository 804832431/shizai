//
//  UIImage+Ellipse.h
//  QianbaoIM
//
//  Created by liu nian on 6/7/14.
//  Copyright (c) 2014 liu nian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ellipse)
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset;
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset size:(CGSize )size;
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color;
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color size:(CGSize )size;
//TODO:compraseImage
- (UIImage *) compraseImage: (UIImage *) largeImage;

+ (UIImage *)imgWithVC:(UIViewController *)vc;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage*)uie_boxblurImageWithBlur:(CGFloat)blur;

+ (UIImage*)transferImage:(UIImage*)oriImage orientation:(UIImageOrientation)orientation;
@end
