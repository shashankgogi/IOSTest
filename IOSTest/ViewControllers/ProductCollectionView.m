//
//  FirstViewController.m
//  IOSTest
//
//  Created by Shashank Gogi on 28/09/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ProductCollectionView.h"
#import "ProductCollectionCell.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "ProductClass.h"
#import "CartListTable.h"
#import "UIImageView+AFNetworking.h"
#import "MWPhotoBrowser.h"

@interface ProductCollectionView (){
    
    IBOutlet UICollectionView *tbl_products;
    NSMutableArray *productArray;
    MBProgressHUD *progressView;
    UIRefreshControl *refreshControl;
    NSMutableArray *photosArray;
    IBOutlet UIView *NoDataFoundView;
    IBOutlet UILabel *NoDataFoundLbl;
    NSArray *mainArray;
}

@end

@implementation ProductCollectionView

#pragma mark-ViewController LyfeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    productArray = [[NSMutableArray alloc] init];
    photosArray = [[NSMutableArray alloc] init];
    refreshControl = [[UIRefreshControl alloc]init];
    NoDataFoundView.hidden  = YES;
    [tbl_products addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(getAllProductData:) forControlEvents:UIControlEventValueChanged];
    [self getAllProductData:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-WebService Call
-(void) getAllProductData:(BOOL)showProgressView{
    
    if (showProgressView)
        progressView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [AppDelegate getAllData:@"getdata" :@"" :@"Get" :^(NSDictionary *kData) {
       
        if (kData) {
            
            if ([[kData valueForKey:@"Error"] isEqualToString:@"Error in connection"]) {
                NoDataFoundView.hidden  = NO;
                NoDataFoundLbl.text = @"Please check your internet connection.";
                [self.view bringSubviewToFront:NoDataFoundView];
            }else{
                [productArray removeAllObjects];
                if ([kData objectForKey:@"products"] != [NSNull null]) {
                    
                    mainArray = [kData objectForKey:@"products"];
                    for (NSDictionary *dict in mainArray) {
                        [productArray addObject:[ProductClass createProductWithName:[dict valueForKey:@"productname"] productPrice:[dict valueForKey:@"price"] vendorName:[dict valueForKey:@"vendorname"] vendorAddress:[dict valueForKey:@"vendoraddress"] productImg:[dict valueForKey:@"productImg"] vendorPhoneNum:[dict valueForKey:@"phoneNumber"]]];
                    }

                    if (productArray.count == 0) {
                        NoDataFoundView.hidden  = NO;
                        [self.view bringSubviewToFront:NoDataFoundView];
                    }else{
                        NoDataFoundView.hidden  = YES;
                        [self.view bringSubviewToFront:tbl_products];
                    }
                }else{
                    NoDataFoundView.hidden  = NO;
                    [self.view bringSubviewToFront:NoDataFoundView];
                }
                
            }
            
            [refreshControl endRefreshing];
            [tbl_products reloadData];
            
        }else{
            NoDataFoundView.hidden  = NO;
            [self.view bringSubviewToFront:NoDataFoundView];
        }
        [progressView hide:YES];
    }];
}
#pragma mark-UICollection View Datasource and Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductCollectionCell *cell = [tbl_products dequeueReusableCellWithReuseIdentifier:@"ProductCell" forIndexPath:indexPath];
    ProductClass *product = [productArray objectAtIndex:indexPath.row];
    cell.productNameLbl.text = product.productName;
    cell.productPriceLbl.text = product.productPrice;
    cell.vendarNameLbl.text = product.vendorName;
    cell.vendorAddrLbl.text = product.vendorAddress;
    [cell.addToCartBtn addTarget:self action:@selector(addToCartBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.addToCartBtn.tag = indexPath.row;
    cell.layer.shadowOffset = CGSizeMake(0, 3);
    cell.layer.shadowRadius = 1;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOpacity = 0.2;
    cell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth = 1;
    [cell.productImg setImageWithURL:[NSURL URLWithString:product.productImg] placeholderImage:[UIImage imageNamed:@"team_user.png"]];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if([UIScreen mainScreen].bounds.size.height == 480 || [UIScreen mainScreen].bounds.size.height == 568)
        return CGSizeMake(135,250);
    else
        return CGSizeMake(165,250);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [tbl_products deselectItemAtIndexPath:indexPath animated:YES];
    NSArray *array = [[mainArray objectAtIndex:indexPath.row] objectForKey:@"productGallery"];
    [photosArray removeAllObjects];
    for (NSString *str in array) {
        [photosArray addObject:[MWPhoto photoWithURL:[NSURL URLWithString:str]]];
    }
    [self initPhotoBrowser];
   
}

-(void) initPhotoBrowser{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = YES; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = NO; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:1];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];

}

#pragma mark-Button Click

-(void) addToCartBtnClicked:(UIButton*)sender{
    
    ProductClass *product = [productArray objectAtIndex:sender.tag];
    CartListTable *entity = [NSEntityDescription insertNewObjectForEntityForName:@"CartListTable" inManagedObjectContext:APPDELEGATE.managedObjectContext];
    entity.productName  = product.productName;
    entity.productPrice  = product.productPrice;
    entity.productImage  = product.productImg;
    entity.vendorName  = product.vendorName;
    entity.vendorAddress  = product.vendorAddress;
    entity.vendorPhoneNum  = product.vendorPhoneNum;
    [APPDELEGATE saveContext];
    
}

#pragma mark-MWPhotoBrowser Delgates
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return photosArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < photosArray.count) {
        return [photosArray objectAtIndex:index];
    }
    return nil;
}

@end
