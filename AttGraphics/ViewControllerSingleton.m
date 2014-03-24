//
//  ViewControllerSingleton.m
//  AttGraphics 2
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 10/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import "ViewControllerSingleton.h"

@implementation ViewControllerSingleton

+(ViewControllerSingleton*) sharedSource
{
    static ViewControllerSingleton *sharedSource = nil;
    if (!sharedSource) {
        sharedSource = [[super allocWithZone:nil] init];
    }
    return sharedSource;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedSource];
}

-(id)init
{
    self = [super init];
    if (self) {
        viewControllers = [[NSArray alloc] init];
    }
    return self;
}

-(id)initWithViewControllers:(NSArray *)array
{
    self = [super init];
    if(self)
    {
        viewControllers = array;
    }
    return self;
}

-(NSArray *)viewControllers
{
    return viewControllers;
}


@end
