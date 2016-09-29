//
//  ProductClass.h
//  IOSTest
//
//  Created by Shashank Gogi on 28/09/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductClass : NSObject

@property (nonatomic , strong) NSString *productName;
@property (nonatomic , strong) NSString *productPrice;
@property (nonatomic , strong) NSString *vendorName;
@property (nonatomic , strong) NSString *vendorAddress;
@property (nonatomic , strong) NSString *productImg;
@property (nonatomic , strong) NSString *vendorPhoneNum;


+(ProductClass *)createProductWithName:(NSString *)ProductName productPrice:(NSString *)ProductPrice vendorName:(NSString *)VendorName vendorAddress:(NSString *)VendorAddress productImg:(NSString *)ProductImg vendorPhoneNum:(NSString *)VendorPhoneNum;

@end
