//
//  MockSpaceInList.swift
//  Smado
//
//  Created by Sergei Volkov on 10.05.2022.
//

import SwiftUI

struct MockSpaceInList: View {
    
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: height)
    }
}
