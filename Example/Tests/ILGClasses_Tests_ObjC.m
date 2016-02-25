//
//  ILGClasses_Tests_ObjC.m
//  ILGDynamicObjC
//
//  Created by Ellen Shapiro on 2/25/16.
//  Copyright © 2016 Isaac Greenspan. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ILGClasses.h"

#import "ILGAppDelegate.h"
#import "ILGViewController.h"
#import "ILGParentProtocol.h"
#import "ILGParentClass.h"
#import "ILGChildClass1.h"
#import "ILGChildClass2.h"
#import "ILGChildClass3.h"
#import "ILGGrandchildClass1.h"

@interface ILGClasses_Tests_ObjC : XCTestCase

@end

@implementation ILGClasses_Tests_ObjC

#pragma mark - Generic passing test tests



#pragma mark - Subclass tests

- (void)testGettingSubclassesOfCustomClass
{
    NSSet *expectedSubclasses = [NSSet setWithArray:@[
                                                      [ILGChildClass1 class],
                                                      [ILGChildClass2 class],
                                                      [ILGChildClass3 class],
                                                      [ILGGrandchildClass1 class],
                                                      ]];
    NSSet *retrievedSubclasses = [ILGClasses subclassesOfClass:[ILGParentClass class]];
    
    XCTAssertEqualObjects(retrievedSubclasses, expectedSubclasses);
}

#pragma mark - Protocol Tests

- (void)testParentClassConformingToProtocolMakesChildClassesReturned
{
    
    NSSet *expectedProtocolConformingClasses = [NSSet setWithArray:@[
                                                      [ILGParentClass class],
                                                      [ILGChildClass1 class],
                                                      [ILGChildClass2 class],
                                                      [ILGChildClass3 class],
                                                      ]];

    NSSet *retrievedClasses = [ILGClasses classesConformingToProtocol:@protocol(ILGParentProtocol)];
    
    XCTAssertEqualObjects(expectedProtocolConformingClasses, retrievedClasses);
    
}

@end
