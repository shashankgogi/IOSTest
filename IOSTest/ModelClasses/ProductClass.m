//
//  ProductClass.m
//  IOSTest
//
//  Created by Shashank Gogi on 28/09/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ProductClass.h"

@implementation ProductClass

@synthesize productName;
@synthesize productPrice;
@synthesize vendorName;
@synthesize vendorAddress;
@synthesize productImg;
@synthesize vendorPhoneNum;

+(ProductClass *)createProductWithName:(NSString *)ProductName productPrice:(NSString *)ProductPrice vendorName:(NSString *)VendorName vendorAddress:(NSString *)VendorAddress productImg:(NSString *)ProductImg vendorPhoneNum:(NSString *)VendorPhoneNum{
    
    ProductClass *product = [[ProductClass alloc] init];
    product.productName = ProductName;
    product.productPrice = ProductPrice;
    product.productImg = ProductImg;
    product.vendorName = VendorName;
    product.vendorAddress = VendorAddress;
    product.vendorPhoneNum = VendorPhoneNum;
    return product;
}


@end
