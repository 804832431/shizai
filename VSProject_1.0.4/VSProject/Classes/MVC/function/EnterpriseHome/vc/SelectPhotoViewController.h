//
//  SelectPhotoViewController.h
//  VSProject
//
//  Created by certus on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "PhotoCollectionViewCell.h"
#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>

typedef void(^CompletedSelection)(UIImage *image);

@interface SelectPhotoViewController : VSBaseViewController

@property(nonatomic,strong)CompletedSelection getPhotosBlock;

@property (nonatomic, assign) CGSize cutSize;

@end
