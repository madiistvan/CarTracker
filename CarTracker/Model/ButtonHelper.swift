//
//  ButtonHelper.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 12. 11..
//

import Foundation
class ButtonHelper: ObservableObject {
    static let shared = ButtonHelper() //SINGELTON
    @Published var disabled : Bool = true
    
}
