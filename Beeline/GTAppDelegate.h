//
//  GTAppDelegate.h
//  Beeline
//
//  Created by Adam Gall on 3/28/14.
//  Copyright (c) 2014 Gall Thomas Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
