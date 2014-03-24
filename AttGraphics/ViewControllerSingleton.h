//
//  ViewControllerSingleton.h
//  AttGraphics 2
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 10/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerSingleton : NSObject
{
    NSArray *viewControllers;
}

+(ViewControllerSingleton*) sharedSource;

-(id) initWithViewControllers:(NSArray*)array;
-(NSArray*) viewControllers;

@end
