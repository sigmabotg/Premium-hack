#import <UIKit/UIKit.h>

// ========== HOOK MẪU CHO APP A ==========
%hook ClassA

// Giả sử app có method - (BOOL)isPremiumUser
- (BOOL)isPremiumUser {
    return YES; // luôn trả về premium
}

// Giả sử app có method - (BOOL)hasUnlockedPro
- (BOOL)hasUnlockedPro {
    return YES;
}

// Trả về dữ liệu giả cho subscription
- (NSDictionary *)subscriptionInfo {
    return @{
        @"status": @"active",
        @"expiry": @"2099-12-31",
        @"plan": @"premium"
    };
}

%end

// ========== HOOK MẪU CHO APP B ==========
%hook ClassB

// Bỏ qua kiểm tra email
- (BOOL)isEmailVerified {
    return YES;
}

// Trả về true cho mọi câu hỏi
- (BOOL)shouldShowPremiumFeature {
    return YES;
}

%end

// ========== HOOK ĐA NĂNG (CHO NHIỀU APP) ==========
%hook NSUserDefaults

// Chặn kiểm tra trạng thái mua hàng
- (BOOL)boolForKey:(NSString *)key {
    if ([key containsString:@"premium"] || 
        [key containsString:@"pro"] || 
        [key containsString:@"unlock"]) {
        return YES;
    }
    return %orig;
}

%end

// ========== HOOK CHO SPRINGBOARD (TUỲ CHỌN) ==========
%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UniversalVIP" 
                                                    message:@"Tweak đã kích hoạt! Mọi premium đều được mở." 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
}

%end
