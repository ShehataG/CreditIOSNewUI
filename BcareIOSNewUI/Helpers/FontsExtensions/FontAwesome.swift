//
//  FontAwesome.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import UIKit
import SwiftUI

@MainActor let isIpad = UIDevice.current.userInterfaceIdiom == .pad
var isAr:Bool {
    return currentKey == "ar"
}
var langText:String {
    return currentKey == "ar" ? "ar" : "en"
}
var langTextCC:String {
    return currentKey == "ar" ? "ar_SA" : "en_US"
}
@MainActor
struct FontAwesome {
    static let lock = String(format:"%C",0xf13e)
    static let arArrow = String(format:"%C",0xf053)
    static let enArrow = String(format:"%C",0xf054)
    static var backIcon:String {
        String(format:"%C",isAr ? 0xf054 : 0xf053)
    }
    static var backRevIcon:String {
        String(format:"%C",isAr ? 0xf053 : 0xf054)
    }
    static let settingsIcon = String(format:"%C",0xf013)
    static let shareIcon = String(format:"%C",0xf064)
    static let openIcon = String(format:"%C",0xf07c)
    static let shareDotsIcon = String(format:"%C",0xf1e0)
    static let likeIcon = String(format:"%C",0xf164)
    static let disLikeIcon = String(format:"%C",0xf165)
    static let eyeHiddenIcon = String(format:"%C",0xf070)
    static let eyeShownIcon = String(format:"%C",0xf06e)
    static let favouriteIcon = String(format:"%C",0xf00c)
    static let unFavouriteIcon = String(format:"%C",0xf004)
    static let deleteIcon = String(format:"%C",0xf146)
    static let correctIcon = String(format:"%C",0xf00c)
    static let wrongIcon = String(format:"%C",0xf00d)
    static let subSettingsIcon = String(format:"%C",0xf085)
    static let bookmarksIcon = String(format:"%C",0xf02e)
    static let searchIcon = String(format:"%C",0xf002)
    static let playNames99Icon = String(format:"%C",0xf144)
    static let stopNames99Icon = String(format:"%C",0xf28b)
    static let checkedIcon = String(format:"%C",0xf058)
    static let playAzkarIcon = String(format:"%C",0xf04b)
    static let closeIcon = String(format:"%C",0xf057)
    static let copyIcon = String(format:"%C",0xf0ea)
    static let playerPauseIcon = String(format:"%C",0xf04c)
    static let playerPlayIcon = String(format:"%C",0xf04b)
    static let playerLoadingIcon = String(format:"%C",0xf110)
    static let downloadIcon = String(format:"%C",0xf019)
    static let downloadingIcon = String(format:"%C",0xf00d)
    static let clearIcon =  String(format:"%C",0xf01e)
    static let sendIcon = String(format:"%C",0xf1d8)
    static let attachIcon = String(format:"%C",0xf0c6)
    static let contactDeleteIcon =  String(format:"%C",0xf1f8)
    static let helpIcon =  String(format:"%C",0xf05a)
    static let arrowDownIcon = String(format:"%C",0xf078)
    static let nextIcon =  String(format:"%C",0xf048)
    static let previousIcon = String(format:"%C",0xf051)
    static let beforeIcon = String(format:"%C",0xf139)
    static let afterIcon =  String(format:"%C",0xf13a)
    static let noteIcon = String(format:"%C",0xf051)
    static let smallNoteIcon = String(format:"%C",0xf14b)
    static let headPhoneIcon = String(format: "%C", 0xf025)
    static let editIcon = String(format: "%C", 0xf044)
    static let saveIcon = String(format: "%C", 0xf0c7)
    static let homeIcon = String(format: "%C", 0xf015)
    static let bagIcon = String(format: "%C", 0xf290)
    static let moreIcon = String(format: "%C", 0xf2a1)
    static let plusIcon = String(format: "%C", 0xf055)
    static let minusIcon = String(format: "%C", 0xf056) 
    static let chatIcon = String(format: "%C", 0xf086)
    static let callIcon = String(format: "%C", 0xf2a0)
    static let warningIcon = String(format: "%C", 0xf071)
    static let keyboardIcon = String(format: "%C", 0xf11c)
    static let faceDownIcon = String(format: "%C", 0xf119)
    static let updateIcon = String(format: "%C", 0xf021)
    static let arrowUpIcon = String(format:"%C",0xf077)
}

struct FontAwesome6 {
    static let topicstIcon = String(format:"%C",0xf5fd)
    static let topicsOtherIcon = String(format:"%C",0xf0b0)
    static let doneIcon = String(format: "%C", 0xf5a2)
    static let syncIcon = String(format: "%C", 0xf2f1)
    static let retryIcon = String(format: "%C", 0xf363)
}
