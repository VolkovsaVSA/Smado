//
//  AddCategory.swift
//  Smado
//
//  Created by Sergei Volkov on 13.02.2022.
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    private var category: CategoryCD?
    @State private var title: String
    @State private var selectedIcon: String
    
    init(category: CategoryCD? = nil) {

        if let cat = category {
            self.category = cat
            _title = State(initialValue: cat.title ?? "")
            _selectedIcon = State(initialValue: cat.image ?? "person.text.rectangle")
        } else {
            self.category = nil
            _title = State(initialValue: "")
            _selectedIcon = State(initialValue: "person.text.rectangle")
        }
        
    }
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Icon(icon: selectedIcon, size: size)
                    TextField("Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
                }
                .padding()
                GradientLine()
                
                ScrollView {
                    LazyVGrid(columns: flexibleLayout, spacing: size/2) {
                        ForEach(iconSet, id: \.self) { icon in
                            IconButton(icon: icon, selectedIcon: $selectedIcon, size: size)
                        }
                    }
                    .padding(8)
                    .padding(.bottom, 20)
                }
            }
            .background(Color.primary.colorInvert())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Category")
            .edgesIgnoringSafeArea(.bottom)

            .toolbar { toolbarsButtons() }
        }
        
        
    }
}


extension AddCategoryView {
    private var flexibleLayout: [GridItem] {
        [GridItem(.adaptive(minimum: size))]
    }
    private var size: CGFloat { UIDevice.isIPhone ? 45 : 70 }
    private var iconSet: [String] {
        [
        "person.text.rectangle", "car", "book", "cross", "creditcard",
        "doc.richtext", "house", "signature", "folder.badge.person.crop", "pills",
        
        "text.justify","list.bullet","flag","mappin","pencil",
        "trash","paperplane","tray.2","calendar","bookmark",
        "paperclip","person.2","sun.max","moon","snow",
        "umbrella","music.note","mic","star","bell",
        "tag","bolt","camera","message","phone",
        "video","envelope","ellipsis.circle","gear","scissors",
        "cart","speedometer","hifispeaker","paintbrush","hammer",
        "link","bandage","sportscourt","alarm","gamecontroller",
        "hand.thumbsup","hand.thumbsdown","chart.pie","waveform.path","gift",
        "airplane","burn","lightbulb","info","questionmark",
        "exclamationmark","plus","minus","dollarsign.circle","eurosign.circle"
    ]
    }
    
    @ToolbarContentBuilder
    fileprivate func toolbarsButtons() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                if let cat = category {
                    cat.title = title
                    cat.image = selectedIcon
                } else {
                    CDStack.shared.createCategory(title: title, icon: selectedIcon)
                }
                
                CDStack.shared.saveContext(context: viewContext)
                dismiss()
                
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20))
            }
        }
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            
        }
    }
    
}
