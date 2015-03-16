//
//  Lesson45_API_TestTests.m
//  Lesson45-API_TestTests
//
//  Created by Nick Bibikov on 2/25/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface Lesson45_API_TestTests : XCTestCase

@end

@implementation Lesson45_API_TestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
