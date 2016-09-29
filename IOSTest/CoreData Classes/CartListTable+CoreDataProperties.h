//
//  CartListTable+CoreDataProperties.h
//  IOSTest
//
//  Created by Shashank Gogi on 29/09/16.
//  Copyright © 2016 Test. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CartListTable.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartListTable (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *productName;
@property (nullable, nonatomic, retain) NSString *productPrice;
@property (nullable, nonatomic, retain) NSString *vendorName;
@property (nullable, nonatomic, retain) NSString *productImage;
@property (nullable, nonatomic, retain) NSString *vendorAddress;
@property (nullable, nonatomic, retain) NSString *vendorPhoneNum;

@end

NS_ASSUME_NONNULL_END
