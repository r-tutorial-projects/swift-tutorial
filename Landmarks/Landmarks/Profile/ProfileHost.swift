//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Ruben Vitt on 04.07.20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var mode
    @State var draftProfile = Profile.default
    @EnvironmentObject var userdata: UserData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.draftProfile = self.userdata.profile
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            
            if self.mode?.wrappedValue == .inactive {
                ProfileSummary(profile: draftProfile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        self.draftProfile = self.userdata.profile
                    }
                    .onDisappear {
                        self.userdata.profile = self.draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(UserData())
    }
}
