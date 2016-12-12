//
//  ViewControllerTestCase.m
//  ViewControllerTester
//
//  Created by Randall Brown on 12/10/16.
//  Copyright © 2016 Randall Brown. All rights reserved.
//

#import "VCSpec.h"
#import "SwiftInterfaces.h"
#import <objc/runtime.h>

static VCSpec *currentTest = nil;

@implementation VCSpec

-(void)spec {
    
}
    
+ (void)initialize {
    VCSpec *spec = [self new];
    [VCTestHolder shared].currentClass = NSStringFromClass(self);
    [spec spec];
}
    
-(void)runTest:(VCTest*)test {
    [test run];
}

+ (SEL)addAppearanceInstanceMethodForTest:(VCTest *)test {
    IMP implementation = imp_implementationWithBlock(^(VCSpec *testCase){
        currentTest = testCase;
        [UIApplication sharedApplication].delegate.window.rootViewController = [VCTestHolder shared].currentViewController;
        
        [test run];
    });
    
    const char *types = [[NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)] UTF8String];
    NSString *selectorName = [test.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    SEL selector = NSSelectorFromString(selectorName);
    class_addMethod(self, selector, implementation, types);
    
    
    return selector;
}
    
+ (SEL)addDisappearanceInstanceMethodForTest:(VCTest *)test {
    IMP implementation = imp_implementationWithBlock(^(VCSpec *testCase){
        currentTest = testCase;
        [UIApplication sharedApplication].delegate.window.rootViewController = [[UIViewController alloc] init];
        
        [test run];
    });
    
    const char *types = [[NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)] UTF8String];
    NSString *selectorName = [test.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    SEL selector = NSSelectorFromString(selectorName);
    class_addMethod(self, selector, implementation, types);
    
    
    return selector;
}

+ (SEL)addInstanceMethodForTest:(VCTest *)test {
    IMP implementation = imp_implementationWithBlock(^(VCSpec *testCase){
        currentTest = testCase;
        [test run];
    });
    
    const char *types = [[NSString stringWithFormat:@"%s%s%s", @encode(id), @encode(id), @encode(SEL)] UTF8String];
    NSString *selectorName = [test.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    SEL selector = NSSelectorFromString(selectorName);
    class_addMethod(self, selector, implementation, types);

    
    return selector;
}
    
+ (NSArray*)testInvocations {
    [VCTestHolder shared].currentClass = NSStringFromClass(self);
    if([VCTestHolder shared].appearanceTests.count + [VCTestHolder shared].disappearanceTests.count <= 0) {
        return nil;
    }

    NSMutableArray *invocations = [NSMutableArray array];
    
    for(VCTest *test in [VCTestHolder shared].appearanceTests) {
        
        SEL selector;
        if(test == [VCTestHolder shared].appearanceTests.firstObject){
            selector = [self addAppearanceInstanceMethodForTest:test];
        }
        else {
            selector = [self addInstanceMethodForTest:test];
        }
        
        NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.selector = selector;
        
        [invocations addObject:invocation];
    }
    
    for(VCTest *test in [VCTestHolder shared].disappearanceTests) {
        SEL selector;
        if(test == [VCTestHolder shared].disappearanceTests.firstObject){
            selector = [self addDisappearanceInstanceMethodForTest:test];
        }
        else {
            selector = [self addInstanceMethodForTest:test];
        }
        
        NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.selector = selector;
        
        [invocations addObject:invocation];
    }
    
    return invocations;
}
    
    - (void)recordFailureWithDescription:(NSString *)description
                                  inFile:(NSString *)filePath
                                  atLine:(NSUInteger)lineNumber
                                expected:(BOOL)expected {
        
        [currentTest.testRun recordFailureWithDescription:description
                                                   inFile:filePath
                                                   atLine:lineNumber
                                                 expected:expected];
    }
    
    
@end
