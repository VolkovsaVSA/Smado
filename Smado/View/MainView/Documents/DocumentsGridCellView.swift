//
//  DocumentsCellView.swift
//  Smado
//
//  Created by Sergei Volkov on 04.04.2022.
//

import SwiftUI

struct DocumentsGridCellView: View {
    
    @StateObject var doc: DocumentCD
    private let action: ()->()
    private let frameWidth: CGFloat
    private let padding: CGFloat
    private let imageFrame: CGFloat
    
    init(doc: DocumentCD, cellWidth: CGFloat, action: @escaping ()->()) {
        self.padding = CGFloat(Int(cellWidth / 8.83))
        
        _doc = StateObject(wrappedValue: doc)
        self.action = action
        self.frameWidth = cellWidth
        self.imageFrame = CGFloat(Int(cellWidth / 3.3))
    }
    
    
    
    var body: some View {
        
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 4) {

                thumbnailStack
                
                Spacer()
                Text(doc.title ?? "")
                    .font(.system(size: padding, weight: .semibold, design: .default))
                    .lineLimit(1)
                HStack {
                    if let date = doc.dateEnd {
                        Text(date.formatted(date: .numeric, time: .omitted))
                            .font(.system(size: padding, weight: .thin, design: .default))
                        Spacer()
                        Circle()
                            .foregroundColor(checkDate(endDate: date))
                            .frame(width: 10, alignment: .leading)
                       
                    }
                    
                }
                .frame(width: frameWidth - 2 * padding, alignment: .leading)
                
            }
            .padding(padding)
            .frame(width: frameWidth, height: frameWidth, alignment: .center)
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .blur(radius: 6, opaque: true)
                    .cornerRadius(padding)
                    .shadow(color: Color.shadowColor, radius: 6, x: 0, y: 3)
            )
        }
        .buttonStyle(.plain)
        
    }
    
}


extension DocumentsGridCellView {
    
    @ViewBuilder
    private var thumbnailStack: some View {
        
        if doc.unwrapImages.isEmpty {
            EmptyThumbnail(cellWidth: frameWidth)
        } else {
            ZStack {
                ForEach(doc.unwrapImages.count > 3 ? Array(0...2).indices : doc.unwrapImages.indices, id:\.self) { index in
                    if index < doc.unwrapImages.count {
                        DocThumbnail(image: doc.unwrapImages[index], cellWidth: frameWidth)
                            .offset(x: CGFloat(index * Int(frameWidth / 4)), y: CGFloat(index) * 3)
                    }
                }
            }
        }
        
    }
    
    
    private func checkDate(endDate: Date)->Color {
        
        var color = Color.green
        
        let dateToday = Date()
        let calendar = Calendar.current
        let componentsToday = calendar.dateComponents([.year, .month, .weekOfMonth, .day], from: dateToday)
        let componentsEndDate = calendar.dateComponents([.year, .month, .weekOfMonth, .day], from: endDate)
        

        if Date().addOrSubtructDay(day: 31) >= endDate {color = .blue}
        if Date().addOrSubtructDay(day: 8) >= endDate {color = .yellow}
        
//        if (componentsToday.year == componentsEndDate.year) &&
//            (componentsToday.month == componentsEndDate.month) { color = .blue }
//        
//        if (componentsToday.year == componentsEndDate.year) &&
//            (componentsToday.month == componentsEndDate.month) &&
//            (componentsToday.weekOfMonth == componentsEndDate.weekOfMonth) { color = .yellow }
        
        if (componentsToday.year == componentsEndDate.year) &&
            (componentsToday.month == componentsEndDate.month) &&
            (componentsToday.day == componentsEndDate.day) { color = .red }
        
        if let todayYear = componentsToday.year,
           let todayMonth = componentsToday.month,
           let todayDay = componentsToday.day,
           let endYaer = componentsEndDate.year,
           let endMonth = componentsEndDate.month,
           let endDay = componentsEndDate.day
        {
            if (todayYear >= endYaer) &&
                (todayMonth >= endMonth) &&
                (todayDay > endDay) { color = .gray }
        }

        return color.opacity(0.7)
    }
    
}


