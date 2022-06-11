//
//  UIViewExtension.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import UIKit

extension UIView {
    
    func makeCircular(){
        layer.cornerRadius  = frame.width / 2
        layer.masksToBounds = true
    }
}
