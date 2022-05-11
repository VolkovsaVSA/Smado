//
//  NotificationSection.swift
//  Smado
//
//  Created by Sergei Volkov on 25.04.2022.
//

import SwiftUI

struct NotificationSection: View {
    
    @AppStorage(UDKeys.sendNotifications) private var isOn: Bool = false
    @State private var allNotificationTime: Date
    @State private var showAlert = false
    
    init() {
        
        if let udDate = UserDefaults.standard.object(forKey: UDKeys.allNotificationTime) as? Date {
            _allNotificationTime = State(initialValue: udDate)
        } else {
            if let date = Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: Date()) {
                _allNotificationTime = State(initialValue: date)
            } else {
                _allNotificationTime = State(initialValue: Date())
            }
        }
     
    }
    
    var body: some View {
        Section(header: Text("Notifications").fontWeight(.semibold).foregroundColor(.primary)){
            SettingsToggleCell(title: NSLocalizedString("Notifications", comment: " ") ,
                               systemImage: "app.badge",
                               isOn: $isOn.animation(),
                               backgroundColor: .red)
            if isOn {
                HStack(alignment: .center, spacing: 6) {
                    SettingsIcon(systemName: "clock", color: .green)
                    DatePicker(selection: $allNotificationTime, displayedComponents: [.hourAndMinute]) {
                        Text("Notifications time")
                    }
                }
            }
            
        }
        .onChange(of: isOn) { newValue in
            if newValue {
                NotificationManager.requestAuthorization { success in
                    isOn = success
                    if !success { showAlert.toggle() }
                }
            }
        }
        .onChange(of: allNotificationTime) { newValue in
            UserDefaults.standard.set(newValue, forKey: UDKeys.allNotificationTime)
        }
        .alert("Warning!", isPresented: $showAlert) {
            Button("Go to settings", role: .destructive) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.canOpenURL(url)
                }
            }
        } message: {
            Text("You have not given permission to send notifications from this app. Please turn on notifications for this app in ios settings.")
        }

    }
    
}

