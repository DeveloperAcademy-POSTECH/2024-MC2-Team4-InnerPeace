import SwiftUI

struct MessageView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var message = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("긴급 메세지를 입력해 주세요.")
                    .font(.headline)
                    .foregroundColor(AppColors.darkGreen)) {
                        ZStack(alignment: .topLeading) {
                            if message.isEmpty {
                                Text("ex. 일시적인 공황장애 발생, 잠시 쉴 수 있게만 도와주세요 등등....")
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                            }
                            TextEditor(text: $message)
                                .frame(height: 140)
                                .opacity(message.isEmpty ? 0.25 : 1)
                        }
                        
                    }
            }
            .navigationTitle("긴급 메세지")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
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
        }
    }
}

#Preview {
    MessageView()
}
