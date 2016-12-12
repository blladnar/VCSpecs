#import <VCSpecs/VCSpecs-Swift.h>

@class VCTest;

SWIFT_CLASS("_TtC7VCSpecs12VCTestHolder")
@interface VCTestHolder
+ (VCTestHolder * _Nonnull)shared;
@property (nonatomic, strong) UIViewController * _Nullable currentViewController;
@property (nonatomic, copy) NSString * _Nonnull currentClass;
@property (nonatomic, readonly, copy) NSArray<VCTest *> * _Nullable appearanceTests;
@property (nonatomic, readonly, copy) NSArray<VCTest *> * _Nullable disappearanceTests;
@end

SWIFT_CLASS("VCTest")
@interface VCTest
- (NSString * _Nonnull)name;
-(void)run;
@end
