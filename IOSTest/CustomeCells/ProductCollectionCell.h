//
//  ProductCollectionCell.h
//  IOSTest
//
//  Created by Shashank Gogi on 28/09/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImg;
@property (strong, nonatomic) IBOutlet UILabel *productNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *productPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *vendarNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *vendorAddrLbl;

@property (strong, nonatomic) IBOutlet UIButton *addToCartBtn;
@end
