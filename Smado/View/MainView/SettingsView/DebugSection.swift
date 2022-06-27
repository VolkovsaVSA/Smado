//
//  DebugSection.swift
//  Smado
//
//  Created by Sergei Volkov on 28.06.2022.
//

import SwiftUI

struct DebugSection: View {
    
    var body: some View {
        Section(header: Text("Debugging").fontWeight(.semibold).foregroundColor(.primary)) {
            NavigationLink("Images", destination: Developer())
        }
    }
}


