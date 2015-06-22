//
//  ILGClasses.h
//  Pods
//
//  Created by Isaac Greenspan on 6/22/15.
//
//

#import <Foundation/Foundation.h>

typedef BOOL(^ILGClassesClassTestBlock)(__strong Class class);

@interface ILGClasses : NSObject

/**
 *  Get an array of all of the classes passing a given test.
 *
 *  @param test The block with which to test each class
 *
 *  @return An array of all of the classes passing the test
 */
+ (NSArray *)classesPassingTest:(ILGClassesClassTestBlock)test;

/**
 *  Get an array of all of the classes that are a subclass of the given class.
 *
 *  Includes any class for which the given class is an ancestor, no matter how far back.  Does not include the given
 *  class in the result.
 *
 *  @param superclass The superclass to look for
 *
 *  @return An array of all of the subclasses of the given class
 */
+ (NSArray *)subclassesOfClass:(Class)superclass;

/**
 *  Get an array of all of the classes that conform to the given protocol.
 *
 *  @param protocol The protocol to look for
 *
 *  @return An array of all of the classes that conform to the given protocol.
 */
+ (NSArray *)classesConformingToProtocol:(Protocol *)protocol;

@end
