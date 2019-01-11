//
//  JRViewCoordinateMacro.m
//  JingRuiOnlineSchool
//
//  Created by maqianli on 2018/9/13.
//  Copyright © 2018年 onesmart. All rights reserved.
//

#import "JRViewCoordinateMacro.h"

//MARK: 手机视图坐标相关
//MARK: tabBar的高度（iPhoneX下为83）
CGFloat tabBarHeight(void){
    
    CGFloat height = 0.0;
    if (kScreenWidth > kScreenHeight) {//当前为横屏
        if (IsSixOneInch || IsSixFiveInch) {
            height = 70.0;
        }else if (IsFiveEightInch) {
            height = 53.0;
        }else if(IsFourSevenInch || IsFiveFiveInch){
            height = 49.0;
        }else if (IsFourInch){
            height = 32.0;
        }
    }else{//当前为竖屏
        if (IsFiveEightInch || IsSixOneInch || IsSixFiveInch) {
            height = 83.0;
        }else if(IsFourSevenInch || IsFiveFiveInch || IsFourInch){
            height = 49.0;
        }
    }
    
    return  height;
}

//MARK: 导航栏高度
CGFloat navigationBarHeight(void){
    
    CGFloat height = 0.0;
    if (kScreenWidth > kScreenHeight) {//当前为横屏
        if (IsFourInch || IsFourSevenInch || IsFiveEightInch) {
            height = 32.0;
        }else if(IsFiveFiveInch || IsSixOneInch || IsSixFiveInch){
            height = 44.0;
        }
    }else{//当前为竖屏
        height = 44.0;
    }
    return height;
}

//MARK: iPhoneX下，底部安全区域高度
CGFloat bottomSafeAreaHeight(void){
    if (kScreenWidth > kScreenHeight) {//当前为横屏
        return IsFiveEightInch ? 21.0 : 0.0;
    }else{//当前为竖屏
        if (IsFiveEightInch || IsSixOneInch || IsSixFiveInch) {
            return 34.0;
        }else{
            return 0.0;
        }
    }
}

//MARK: 相对于iPhone6(375 * 667)的比例--iPhone 6，也是目前psd设计图尺寸，比例一般用于图片的等比拉伸
CGFloat viewScaleX_375(void){
    if (kScreenWidth > kScreenHeight) {//当前为横屏
        return kScreenWidth / 667.0;
    }else{//当前为竖屏
        return kScreenWidth / 375.0;
    }
}

//MARK: 同上
CGFloat viewScaleY_667(void){
    if (kScreenWidth > kScreenHeight) {//当前为横屏
        return kScreenHeight / 375.0;
    }else{//当前为竖屏
        return kScreenHeight / 667.0;
    }
}


//MARK: pad视图坐标相关
//MARK: tabBar的高度
CGFloat tabBarHeightOfPad(void){
    return 49.0;
}

//MARK: 导航栏高度
CGFloat navigationBarHeightOfPad(void){
    return 50.0;
}








