//
//  MainTypeItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation

struct MainTypeItem {
    let key:String
    let opacity:CGFloat
    let backImage:String
    let frontImage:String
    let title:String
    let desc:String
    let hasPolicy:Bool
    let discount:String?
    let isActive:Bool
    init(key:String,opacity: CGFloat = 0.0, backImage: String,frontImage:String="", title: String, desc: String="", hasPolicy: Bool=false,discount:String? = nil,isActive:Bool) {
        self.key = key
        self.opacity = opacity
        self.backImage = backImage
        self.frontImage = frontImage
        self.title = title
        self.desc = desc
        self.hasPolicy = hasPolicy
        self.discount = discount
        self.isActive = isActive
    }
}
 
