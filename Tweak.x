#import <UIKit/UIKit.h>

// ========== HOOK CHO APP A ==========
%hook ClassA
- (BOOL)isPremiumUser {
    return YES;
}
- (BOOL)hasUnlockedPro {
    return YES;
}
- (NSDictionary *)subscriptionInfo {
    return @{
        @"status": @"active",
        @"expiry": @"2099-12-31",
        @"plan": @"premium"
    };
}
%end

// ========== HOOK CHO APP B ==========
%hook ClassB
- (BOOL)isEmailVerified {
    return YES;
}
- (BOOL)shouldShowPremiumFeature {
    return YES;
}
%end

// ========== HOOK ĐA NĂNG ==========
%hook NSUserDefaults
- (BOOL)boolForKey:(NSString *)key {
    if ([key containsString:@"premium"] || 
        [key containsString:@"pro"] || 
        [key containsString:@"unlock"]) {
        return YES;
    }
    return %orig;
}
%end

// ========== HOOK SPRINGBOARD ==========
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:@"UniversalVIP" 
        message:@"Tweak đã kích hoạt! Mọi premium đều được mở." 
        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction 
        actionWithTitle:@"OK" 
        style:UIAlertActionStyleDefault 
        handler:nil];
    
    [alert addAction:okAction];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}

%end
