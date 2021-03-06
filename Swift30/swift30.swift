//
//  swift30.swift
//  Swift30
//
//  Created by liupengkun on 2020/1/8.
//  Copyright © 2020 liupengkun. All rights reserved.
//

import UIKit

/** 导航栏的高 44 */
let kNavigationBarHeight = CGFloat(44)

/** *屏幕高*/
let kScreenHeight = UIScreen.main.bounds.size.height
/** *屏幕宽*/
let kScreen_width = UIScreen.main.bounds.size.width

/** 状态条高度 */
let kStatusBarHeight = UIApplication.shared.statusBarFrame.height

/** 导航栏+状态条 */
let kNavigationHeight = kNavigationBarHeight + kStatusBarHeight

/* 底部安全区 区 */
let kBottomHomeHeight = CGFloat(kStatusBarHeight > 20.0 ? 34.0 : 0.0)

/*! 安全区，屏高 - home 区 - 导航 - 状态栏 */
let kSafeAreaHeight = (kScreenHeight - kNavigationHeight - kBottomHomeHeight)
