//
//  ContactSettingView.swift
//  SumSumZip
//
//  Created by heesohee on 5/20/24.
//

import SwiftUI
import ContactsUI
import Combine

struct ContactSettingView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var pickedNumber: String?
    @State private var pickedNumber2: String?
    @State private var pickedNumber3: String?
    
    @State var relation: String = ""
    @State var relation2: String = ""
    @State var relation3: String = ""
    
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                
                Section {
                    HStack (spacing: 10) {
                        Button {
                            openContactPicker(coordinator: coordinator, for: \.pickedNumber)
                        }
                    label:{
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(AppColors.darkGreen)
                        
                    }
                        TextField("관계", text: $relation)
                            .frame(width: 60)
                            .onReceive(relation.publisher.collect()) {
                                self.relation = String($0.prefix(10))
                            }
                        Spacer()
                        
                        Text(pickedNumber ?? "")
                            .onReceive(coordinator.$pickedNumber) { phoneNumber in
                                self.pickedNumber = phoneNumber
                            }
                        Spacer()
                        
                        // 연락처 삭제 버튼
                        Button {
                            pickedNumber = nil
                            relation = ""
                        } label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(AppColors.darkGreen)
                        } // :  연락처 삭제 버튼
                        
                    }
                    .padding(20)
                    .frame(width: 360, height: 60)
                    .background(AppColors.paleGreen)
                    .cornerRadius(10)
                    
                    // 2번 째 연락처
                    HStack (spacing: 10) {
                        Button {
                            openContactPicker(coordinator: coordinator, for: \.pickedNumber2)
                        }
                    label:{
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(AppColors.darkGreen)
                        
                    }
                        TextField("관계", text: $relation2)
                            .frame(width: 60)
                            .onReceive(relation2.publisher.collect()) {
                                self.relation2 = String($0.prefix(10))
                            }
                        Spacer()
                        
                        Text(pickedNumber2 ?? "")
                            .onReceive(coordinator.$pickedNumber2) { phoneNumber in
                                self.pickedNumber2 = phoneNumber
                            }
                        Spacer()
                        
                        // 연락처 삭제 버튼
                        Button {
                            pickedNumber2 = nil
                            relation2 = ""
                        } label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(AppColors.darkGreen)
                        } // :  연락처 삭제 버튼
                        
                    }
                    .padding(20)
                    .frame(width: 360, height: 60)
                    .background(AppColors.paleGreen)
                    .cornerRadius(10)
                    
                    // 3번 째 연락처
                    HStack (spacing: 10) {
                        Button {
                            openContactPicker(coordinator: coordinator, for: \.pickedNumber3)
                        }
                    label:{
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(AppColors.darkGreen)
                        
                    }
                        TextField("관계", text: $relation3)
                            .frame(width: 60)
                            .onReceive(relation3.publisher.collect()) {
                                self.relation3 = String($0.prefix(10))
                            }
                        Spacer()
                        
                        Text(pickedNumber3 ?? "")
                            .onReceive(coordinator.$pickedNumber3) { phoneNumber in
                                self.pickedNumber3 = phoneNumber
                            }
                        Spacer()
                        
                        // 연락처 삭제 버튼
                        Button {
                            pickedNumber3 = nil
                            relation3 = ""
                        } label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(AppColors.darkGreen)
                        } // :  연락처 삭제 버튼
                        
                    }
                    .padding(20)
                    .frame(width: 360, height: 60)
                    .background(AppColors.paleGreen)
                    .cornerRadius(10)
                    
                } header: {
                    Text("긴급 연락처를 입력해 주세요")
                    //    .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(AppColors.darkGreen)
                }
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("긴급 연락처")
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

func openContactPicker(coordinator: Coordinator, for keyPath: ReferenceWritableKeyPath<Coordinator, String?>) {
    let contactPicker = CNContactPickerViewController()
    contactPicker.delegate = coordinator
    coordinator.keyPath = keyPath
    contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
    contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
    contactPicker.predicateForSelectionOfContact = NSPredicate(format: "phoneNumbers.@count == 1")
    contactPicker.predicateForSelectionOfProperty = NSPredicate(format: "key == 'phoneNumbers'")
    let scenes = UIApplication.shared.connectedScenes
    let windowScenes = scenes.first as? UIWindowScene
    let window = windowScenes?.windows.first
    window?.rootViewController?.present(contactPicker, animated: true, completion: nil)
}

class Coordinator: NSObject, ObservableObject, CNContactPickerDelegate {
    @Published var pickedNumber: String?
    @Published var pickedNumber2: String?
    @Published var pickedNumber3: String?
    
    var keyPath: ReferenceWritableKeyPath<Coordinator, String?>?
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            handlePhoneNumber(phoneNumber)
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        if contactProperty.key == CNContactPhoneNumbersKey, let phoneNumber = contactProperty.value as? CNPhoneNumber {
            handlePhoneNumber(phoneNumber.stringValue)
        }
    }
    
    private func handlePhoneNumber(_ phoneNumber: String) {
        let phoneNumberWithoutSpace = phoneNumber.replacingOccurrences(of: " ", with: "")
        let sanitizedPhoneNumber = phoneNumberWithoutSpace.hasPrefix("+") ? String(phoneNumberWithoutSpace.dropFirst()) : phoneNumberWithoutSpace
        DispatchQueue.main.async {
            if let keyPath = self.keyPath {
                self[keyPath: keyPath] = sanitizedPhoneNumber
            }
        }
    }
    
    // Fuction
    //    func delete(indexSet: IndexSet) {
    //        fruits.remove(atOffsets: indexSet)
    //    }
    //
    //    func move(indices: IndexSet, newOffset: Int) {
    //        fruits.move(fromOffsets: indices, toOffset: newOffset)
    //    }
}

#Preview {
    ContactSettingView()
}

// 딕셔너리 자료형
// enum

