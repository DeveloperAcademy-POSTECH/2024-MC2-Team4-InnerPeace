//
//  MessageVIew.swift
//  SumSumZip
//
//  Created by heesohee on 5/20/24.
//

import SwiftUI
import Foundation
//import SwiftData


struct MessageView: View {
    //    @Environment(\.modelContext) private var modelContext
    //    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var message: String
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 6) {
                
                Text("긴급 메세지를 작성해 주세요")
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.darkGreen)
                
                
                TextEditor(text: $message)
                    .padding(4)
                    .background(AppColors.paleGreen.opacity(1))
                    .frame(width: 359, height: 90)
                    .cornerRadius(10)
                    .scrollContentBackground(.hidden)
                    .onReceive(message.publisher.collect()) {
                        self.message = String($0.prefix(100))
                        // 100자로 입력값 고정
                    }
                
                Spacer()
                
            }
            .padding(.top, 50)
            .navigationTitle("긴급 메세지")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        MessageManager.shared.saveMessage(message)
                        print("dd")
                        dismiss()
                        
                    } label: {
                        HStack {
                            Text("저장")
                                .fontWeight(.bold)
                                .foregroundColor(AppColors.darkGreen)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                    .foregroundColor(AppColors.darkGreen)
                }
            }
            
        }.navigationBarBackButtonHidden ()
        .onAppear {
           message = MessageManager.shared.fetchMessage() != "" ? MessageManager.shared.fetchMessage() : ""
        }
        
    }
}

//#Preview {
//    MessageView()
//}

struct MessageView_Previews: PreviewProvider {
    @State static var message = "긴급 메시지"

    static var previews: some View {
        MessageView(message: $message)
    }
}
