//
//  AppDelegate.h
//  IOSTest
//
//  Created by Shashank Gogi on 28/09/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//CoreData variables
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(void)getAllData:(NSString *)ApiName :(NSString *)RestMsg :(NSString *)RequestType :(void (^)(NSDictionary* kData))handler;
- (void)saveContext;
@end

