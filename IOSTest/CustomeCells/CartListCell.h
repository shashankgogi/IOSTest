//
//  CartListCell.h
//  IOSTest
//
//  Created by Shashank Gogi on 28/09/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImg;
@property (strong, nonatomic) IBOutlet UILabel *productNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *vendorNameLbl;

@property (strong, nonatomic) IBOutlet UILabel *venderAddrLbl;
@property (strong, nonatomic) IBOutlet UIButton *callVendorBtn;
@property (strong, nonatomic) IBOutlet UIButton *removeBtn;
@property (strong, nonatomic) IBOutlet UIView *cartView;

@property (strong, nonatomic) IBOutlet UILabel *productPriceLbl;
@end
