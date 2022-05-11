//
//  BackupSection.swift
//  Debts
//
//  Created by Sergei Volkov on 14.12.2021.
//

import SwiftUI

struct BackupSection: View {

    @AppStorage(UDKeys.iCloudSync) private var iCloudSync: Bool = false
    @AppStorage(UDKeys.fw) private var isFullVersion: Bool = false
    
    @State private var alertShow = false
    
    var body: some View {
        Section(header: Text("Backup").fontWeight(.semibold).foregroundColor(.primary)
        ) {
            if isFullVersion {
                VStack(alignment: .leading, spacing: 2) {
                    SettingsToggleCell(title: NSLocalizedString("Backup", comment: " "),
                                       systemImage: iCloudSync ? "checkmark.icloud.fill" : "icloud.slash",
                                       isOn: $iCloudSync.animation(),
                                       backgroundColor: iCloudSync ? .blue : .red)
                    if FileManager.default.ubiquityIdentityToken == nil {
                        Text("For backups please login into your account in ios settings")
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.system(size: 10, weight: .thin, design: .default))
                    }
                    
                }
                .disabled(FileManager.default.ubiquityIdentityToken == nil)
                .onAppear() {
                    if iCloudSync {
                        iCloudSync = FileManager.default.ubiquityIdentityToken != nil
                    }
                }
                
            } else {
                HStack {
                    Spacer()
                    Text("Data backup available by subscription only")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            
        }

    }
}
