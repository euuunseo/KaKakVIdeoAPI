//
//  ReuseableViewProtocol.swift
//  SeSACWeek4
//
//  Created by 고은서 on 2023/10/27.
//

import Foundation
import UIKit

protocol ReuseableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReuseableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    
}

extension UITableViewCell: ReuseableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
