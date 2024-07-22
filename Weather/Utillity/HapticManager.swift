//
//  HapticManager.swift
//  Weather
//
//  Created by MyBook on 21.07.2024.
//

import UIKit

class HapticManager {
    
    static let shared = HapticManager()
    
    private init() {}
    
    func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}
