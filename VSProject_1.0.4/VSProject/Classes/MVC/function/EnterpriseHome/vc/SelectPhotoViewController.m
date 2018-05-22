//
//  SelectPhotoViewController.m
//  VSProject
//
//  Created by certus on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "VPImageCropperViewController.h"

@interface SelectPhotoViewController () <UIAlertViewDelegate> {

    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *photoArray;
    UICollectionView *photoCollection;
}

@property(nonatomic,strong)ALAssetsGroup *myGroup;

@end

@implementation SelectPhotoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self vs_setTitleText:@"选择图片"];
    self.view.backgroundColor = [UIColor whiteColor];

    [self enumerateGroups];
    
    float cell_width = (WIDTH_SCREEN-CELL_MARGIN*4-20)/3;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(CELL_MARGIN, CELL_MARGIN, CELL_MARGIN, CELL_MARGIN);
    flowLayout.itemSize = CGSizeMake(cell_width, cell_width);
    flowLayout.minimumInteritemSpacing = 0;
    
    photoCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 7, WIDTH_SCREEN-20, HEIGHT_SCREEN-7) collectionViewLayout:flowLayout];
    photoCollection.backgroundColor = [UIColor whiteColor];
    photoCollection.showsVerticalScrollIndicator = NO;
    photoCollection.delegate = (id<UICollectionViewDelegate>)self;
    photoCollection.dataSource = (id<UICollectionViewDataSource>)self;
    [photoCollection registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
    [self.view addSubview:photoCollection];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //相册权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        //无权限 引导去开启
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取相册权限" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        [alert setTag:0];
        [alert show];
    } else {
        [photoCollection reloadData];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertView.tag == 0) {
            // 无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        } else if (alertView.tag == 1) {
            // 无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication]canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
        }
    }
    
}

- (void)enumerateGroups {
    
    
    assetsLibrary = [[ALAssetsLibrary alloc]init];
    __weak typeof(self) weakself = self;
    void (^enumerateGroupsBlock)(ALAssetsGroup *group, BOOL *stop) = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            _myGroup = group;
            [weakself enumeratePhotoss];
        }
    };
    void (^enumerateFailedBlock)(NSError *error) = ^(NSError *error) {
        NSLog(@"error=%@",error);
    };
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:enumerateGroupsBlock failureBlock:enumerateFailedBlock];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:enumerateGroupsBlock failureBlock:enumerateFailedBlock];
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupLibrary usingBlock:enumerateGroupsBlock failureBlock:enumerateFailedBlock];
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:enumerateGroupsBlock failureBlock:enumerateFailedBlock];
    
}

- (void)enumeratePhotoss {
    
    photoArray = [NSMutableArray arrayWithObject:[UIImage imageNamed:@"usercenter_choosepic"]];
    dispatch_queue_t queue = dispatch_queue_create("SelectPhotosViewController.enumeratePhotoss", DISPATCH_QUEUE_SERIAL);
    
    [_myGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        dispatch_sync(queue, ^{
            if (result) {
                [photoArray addObject:result];
            }
        });
        dispatch_sync(queue, ^{
            [photoCollection reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)actionBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)actionPhotos{
    
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        //无权限 引导去开启
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取相机权限" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        [alert setTag:0];
        [alert show];
    } else {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = (id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image =[info objectForKey:@"UIImagePickerControllerEditedImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (_cutSize.height != 0) {
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, self.view.frame.size.height/2-_cutSize.height/2, _cutSize.width, _cutSize.height) limitScaleRatio:3.0];
        imgEditorVC.delegate = (id<VPImageCropperDelegate>)self;
        [self.navigationController pushViewController:imgEditorVC animated:YES];
    } else {
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = (id<VPImageCropperDelegate>)self;
        [self.navigationController pushViewController:imgEditorVC animated:YES];
    }

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.photoImageView.image = [photoArray objectAtIndex:0];
    }else {
        ALAsset *indexAsset = [photoArray objectAtIndex:indexPath.row];
        UIImage *image = [UIImage imageWithCGImage:[indexAsset aspectRatioThumbnail]];

        cell.photoImageView.image = image;
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self actionPhotos];
    }else {
        ALAsset *indexAsset = [photoArray objectAtIndex:indexPath.row];
        ALAssetRepresentation *asp = [indexAsset defaultRepresentation];
        UIImage *image = [UIImage imageWithCGImage:[asp fullScreenImage] scale:[asp scale] orientation:UIImageOrientationUp];
        
        if (_cutSize.height != 0) {
            VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, self.view.frame.size.height/2-_cutSize.height/2, _cutSize.width, _cutSize.height) limitScaleRatio:3.0];
            imgEditorVC.delegate = (id<VPImageCropperDelegate>)self;
            [self.navigationController pushViewController:imgEditorVC animated:YES];
        } else {
            VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
            imgEditorVC.delegate = (id<VPImageCropperDelegate>)self;
            [self.navigationController pushViewController:imgEditorVC animated:YES];
        }
    }
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    _getPhotosBlock(editedImage);
    
    NSArray *vcs = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[vcs objectAtIndex:vcs.count-3] animated:YES];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
