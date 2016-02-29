//
//  ILGClasses.m
//  Pods
//
//  Created by Isaac Greenspan on 6/22/15.
//
//

#import "ILGClasses.h"

#import <objc/runtime.h>

@implementation ILGClasses

#pragma mark - Test helpers

+ (NSSet *)classesPassingTest:(ILGClassesClassTestBlock)test
{
    int numClasses;
    Class *classes = NULL;
    
    numClasses = objc_getClassList(NULL, 0);
    if (!numClasses) {
        return [NSSet set];
    }
    
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    if (!test) {
        NSSet *result = [NSSet setWithObjects:classes count:numClasses];
        free(classes);
        return result;
    }
    
    NSMutableSet *passingClasses = [NSMutableSet set];
    for (int index = 0; index < numClasses; index++) {
        Class class = classes[index];
        if (test(class)) {
            [passingClasses addObject:class];
        }
    }
    free(classes);
    return [passingClasses copy];
}

+ (BOOL)doAnySuperclassesOfClass:(Class)class passTest:(ILGClassesClassTestBlock)test
{
    // Start with the given class...
    Class workingClass = class;
    
    // Otherwise, walk up the superclass chain until we get Nil or the superclass
    // passes the test.
    do {
        workingClass = class_getSuperclass(workingClass);
    } while (workingClass && !test(workingClass));
    
    // If we got Nil, we went all the way up and nothing passed the test.
    if (!workingClass) {
        return NO;
    }
    
    // Otherwise, one of the tests passed, yay!.
    return YES;
}

+ (BOOL)class:(Class)classToCheck orAnyOfItsSuperclassesPassesTest:(ILGClassesClassTestBlock)test
{
    //Check the initial class against the test
    if (test(classToCheck)) {
        //If it passed, hooray! Return and bail.
        return YES;
    }
    
    // Otherwise, keep looking to see if any of the superclasses pass the test.
    return [self doAnySuperclassesOfClass:classToCheck passTest:test];
}

#pragma mark - Convenience Methods

+ (NSSet *)subclassesOfClass:(Class)superclass
{
    return [self classesPassingTest:^BOOL(Class class) {
        // Check to see if any superclasses of the class passed in...
        return [self doAnySuperclassesOfClass:class passTest:^BOOL(Class workingClass) {
            // are the superclass we're looking for.
            return workingClass == superclass;
        }];
    }];
}

+ (NSSet *)classesConformingToProtocol:(Protocol *)protocol
{
    return [self classesPassingTest:^BOOL(Class class) {
        // Check to see if the class or any of its superclasses...
        return [self class:class orAnyOfItsSuperclassesPassesTest:^BOOL(Class workingClass) {
            // Conform to the protocol we're looking for.
            return class_conformsToProtocol(workingClass, protocol);
        }];
    }];
}

@end
