//
//  AppDelegate.m
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 03/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Aloca os View Controllers
    MainViewController *mainVC = [[MainViewController alloc] init];
    TabViewController *tabVC = [[TabViewController alloc] init];
    
    //Cria a TabBar
//    UITabBarController *tabBar = [[UITabBarController alloc] init];
    NSArray *a = [NSArray arrayWithObjects:mainVC, tabVC, nil];
//    [tabBar setViewControllers:a];
    ViewControllerSingleton *aVC = [[ViewControllerSingleton alloc] initWithViewControllers:a];
    aVC = nil;
    
    //Cria o NavController
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [nav setNavigationBarHidden:YES];
    [nav setToolbarHidden:NO];
    [[nav toolbar] setBarStyle:UIBarStyleBlackTranslucent];
    
    [[self window] setRootViewController:nav];
    
    //Cria o contexto do CoreData
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *erro;
    
    //Realiza um Select para carregar os dados do CoreData
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDPersonagem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *personagensRecebidos = [context executeFetchRequest:fetchRequest error:&erro];
    
    //Guarda os dados do CoreData para o DataSource
    for (CDPersonagem *pR in personagensRecebidos) {
        
        //Cria os Objetos que serão passados
        Personagem *p = [[Personagem alloc] init];
        CDAtributos *att = [pR relationship];
        
        //Define as caracteristicas do 'novo'personagem
        [p setNome:[pR nome]];
        [p setRaca:[pR raca]];
        [p setNivel:[[pR nivel] intValue]];
        [p setClasse:[pR classe]];
        [p setAlinhamento:[pR alinhamento]];
        
        //Define os atributos do 'novo' personagem
        [p setAtributoNoIndice:0:[[att forca] intValue]];
        [p setAtributoNoIndice:1:[[att constituicao] intValue]];
        [p setAtributoNoIndice:2:[[att destreza] intValue]];
        [p setAtributoNoIndice:3:[[att inteligencia] intValue]];
        [p setAtributoNoIndice:4:[[att sabedoria] intValue]];
        [p setAtributoNoIndice:5:[[att carisma] intValue]];
        
        [[PersonagensDataSource sharedSource] addPersonagem:p];
    }
    
    //Define a cor do Background e torna  a tela visivel
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self salvarCoreData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self salvarCoreData];
}

-(void) salvarCoreData
{
    PersonagensDataSource *dtSource = [PersonagensDataSource sharedSource];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *erro;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDPersonagem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *personagensRecebidos = [context executeFetchRequest:fetchRequest error:&erro];
    
    for (CDPersonagem *pr in personagensRecebidos) {
        [context deleteObject:pr];
    }
    
    for (Personagem *pR in [dtSource todosPersonagens]) {
        CDPersonagem *p = [NSEntityDescription insertNewObjectForEntityForName:@"CDPersonagem" inManagedObjectContext:context];
        [p setNome:[pR nome]];
        [p setRaca:[pR raca]];
        [p setNivel:[NSNumber numberWithInt:[pR nivel]]];
        [p setClasse:[pR classe]];
        [p setAlinhamento:[pR alinhamento]];
        
        CDAtributos *att = [NSEntityDescription insertNewObjectForEntityForName:@"CDAtributos" inManagedObjectContext:context];
        [att setForca:[NSNumber numberWithInt:[pR atributoNoIndice:0]]];
        [att setConstituicao:[NSNumber numberWithInt:[pR atributoNoIndice:1]]];
        [att setDestreza:[NSNumber numberWithInt:[pR atributoNoIndice:2]]];
        [att setInteligencia:[NSNumber numberWithInt:[pR atributoNoIndice:3]]];
        [att setSabedoria:[NSNumber numberWithInt:[pR atributoNoIndice:4]]];
        [att setCarisma:[NSNumber numberWithInt:[pR atributoNoIndice:5]]];
        
        [p setRelationship:att];
        [att setRelationship:p];
    }
    
    if (![context save:&erro]) {
        NSLog(@"Impossivel salvar: %@", [erro localizedDescription]);
    }
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataBasics" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataBasics.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
