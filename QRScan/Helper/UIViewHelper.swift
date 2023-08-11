//
//  UIViewHelper.swift
//  QRScan
//
//  Created by Naratama on 10/08/23.
//

import UIKit

extension UIView {
    func anchorAllView(to: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: to.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: to.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: to.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: to.bottomAnchor).isActive = true
    }
    
    func anchorAllViewWith16Constant(to: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: to.topAnchor, constant: 16).isActive = true
        leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: 16).isActive = true
        trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -16).isActive = true
        bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -16).isActive = true
    }
}
