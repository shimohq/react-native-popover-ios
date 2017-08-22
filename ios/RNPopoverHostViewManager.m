//
//  RNPopoverHostViewManager.m
//  RNPopoverIOS
//
//  Created by Bell Zhong on 2017/8/10.
//  Copyright © 2017年 shimo. All rights reserved.
//

#import "RNPopoverHostViewManager.h"

#import "RNPopoverHostView.h"
#import "RNPopoverHostViewController.h"

#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import <React/RCTShadowView.h>
#import <React/RCTUtils.h>

@interface RNPopoverHostViewManager() <RNPopoverHostViewInteractor>

@property (nonatomic, copy) RCTPromiseResolveBlock dismissResolve;

@end

@implementation RNPopoverHostViewManager  {
    NSHashTable *_hostViews;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(animated, BOOL)
RCT_EXPORT_VIEW_PROPERTY(backgroundColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(sourceView, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(sourceRect, CGRect)
RCT_EXPORT_VIEW_PROPERTY(permittedArrowDirections, NSArray)
RCT_EXPORT_VIEW_PROPERTY(preferredContentSize, CGSize)
RCT_EXPORT_VIEW_PROPERTY(onShow, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onHide, RCTDirectEventBlock)

- (UIView *)view {
    RNPopoverHostView *view = [[RNPopoverHostView alloc] initWithBridge:self.bridge];
    view.delegate = self;
    if (!_hostViews) {
        _hostViews = [NSHashTable weakObjectsHashTable];
    }
    [_hostViews addObject:view];
    return view;
}

RCT_EXPORT_METHOD(presentWithOptions:(NSDictionary *)options
                  callback:(RCTResponseSenderBlock)callback)
{

}

RCT_REMAP_METHOD(dismiss,
                 dismissWithReactTag:(nonnull NSNumber *)reactTag Resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    __weak typeof(self) weakSelf = self;
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        __kindof UIView *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RNPopoverHostView class]]) {
            RNPopoverHostView *hostView = view;
            if (hostView.presented) {
                weakSelf.dismissResolve = resolve;
                [hostView dismissViewController];
            } else {
                resolve(nil);
            }
        } else {
            reject(@"parameters error", [NSString stringWithFormat:@"invalid parameter: %@", [reactTag stringValue]], nil);
        }
    }];
}

#pragma mark - RCTInvalidating

- (void)invalidate {
    for (RNPopoverHostView *hostView in _hostViews) {
        [hostView invalidate];
    }
    [_hostViews removeAllObjects];
}

#pragma mark - RNPopoverHostViewInteractor

- (void)presentPopoverHostView:(RNPopoverHostView *_Nullable)popoverHostView withViewController:(RNPopoverHostViewController *_Nonnull)viewController animated:(BOOL)animated {
    dispatch_block_t completionBlock = ^{
        if (popoverHostView.onShow) {
            popoverHostView.onShow(nil);
        }
    };
    
    [popoverHostView.reactViewController presentViewController:viewController animated:animated completion:completionBlock];
}

- (void)dismissPopoverHostView:(RNPopoverHostView *_Nullable)popoverHostView withViewController:(RNPopoverHostViewController *_Nullable)viewController animated:(BOOL)animated {
    [viewController dismissViewControllerAnimated:animated completion:^{
        if (self.dismissResolve) {
            self.dismissResolve(nil);
            self.dismissResolve = nil;
        }
        if (popoverHostView.onHide) {
            popoverHostView.onHide(nil);
        }
    }];
    
}

@end
