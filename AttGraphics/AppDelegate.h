//
//  AppDelegate.h
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 03/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "MainViewController.h"
#import "TabViewController.h"
#import "PersonagensDataSource.h"

#import "CDPersonagem.h"
#import "CDAtributos.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
