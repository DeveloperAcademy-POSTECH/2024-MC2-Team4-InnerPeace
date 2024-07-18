//
//  PatientInfoEditorView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI
import ContactsUI

struct PatientContactEditorView: View{
    @State var pickedNumber: String?
    @State var pickedNumber2: String?
    @State var pickedNumber3: String?
    
    @State var relation: String = ""
    @State var relation2: String = ""
    @State var relation3: String = ""
    
    @Binding var numOfRelation: String
    @StateObject private var coordinator = Coordinator()
    
    var body: some View{
        ZStack{
            
            Rectangle()
                .frame(width:.infinity, height: 170)
                .foregroundColor(AppColors.white)
                .cornerRadius(17)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
            
            VStack(alignment: .leading){
                
                
                HStack(spacing: 10) {
                    
                    TextField("관계", text: $relation)
                        .font(.system(size: 15))
                        .frame(width: 60, height:36)
                        .foregroundColor(AppColors.black)
                        .background(AppColors.gray04)
                        .cornerRadius(17)
                        .multilineTextAlignment(.center)
                        .onReceive(relation.publisher.collect()) {
                            self.relation = String($0.prefix(10))
                        }
                    // 첫 번째 연락처
                    Button {
                        openContactPicker(coordinator: coordinator, for: \.pickedNumber)
                    } label: {
                        if pickedNumber == ""{
                            ZStack{
                                
                                Rectangle()
                                    .frame(width:.infinity, height:40)
                                    .foregroundColor(AppColors.gray04)
                                    .cornerRadius(17)
                                Image(systemName: "plus")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppColors.white)
                                Text(pickedNumber ?? "")
                                    .foregroundStyle(AppColors.black)
                                    .font(.system(size: 15))
                                    .onReceive(coordinator.$pickedNumber) { phoneNumber in
                                        self.pickedNumber = phoneNumber
                                    }
                            }
                        } else {
                            ZStack{
                                Rectangle()
                                    .frame(width:.infinity, height:40)
                                    .foregroundColor(AppColors.gray04)
                                    .cornerRadius(17)
                                Image(systemName: "plus")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppColors.white)
                                Text(pickedNumber ?? "")
                                    .foregroundStyle(AppColors.black)
                                    .font(.system(size: 15))
                                    .onReceive(coordinator.$pickedNumber) { phoneNumber in
                                        self.pickedNumber = phoneNumber
                                    }
                            }
                        }
                    }
                    
                    Button {
                        pickedNumber = nil
                        relation = ""
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width:36, height:36)
                                .foregroundColor(AppColors.gray03)
                            
                            Image(systemName: "trash")
                                .font(.system(size:15))
                                .foregroundColor(AppColors.white)
                        }
                    }
                }
                .padding(20)
                .frame(width: .infinity, height: 48)
                .cornerRadius(10)
                
                
                
                // 두 번째 연락처
                HStack(spacing: 10) {
                    
                    TextField("관계", text: $relation2)
                        .font(.system(size: 15))
                        .frame(width: 60, height:36)
                        .foregroundColor(AppColors.black)
                        .background(AppColors.gray04)
                        .cornerRadius(17)
                        .multilineTextAlignment(.center)
                        .onReceive(relation2.publisher.collect()) {
                            self.relation2 = String($0.prefix(10))
                        }
                    
                    Button {
                        openContactPicker(coordinator: coordinator, for: \.pickedNumber2)
                    } label: {
                        if pickedNumber2 == ""{
                            ZStack{
                                Rectangle()
                                    .frame(width:.infinity, height:40)
                                    .foregroundColor(AppColors.gray04)
                                    .cornerRadius(17)
                                Image(systemName: "plus")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppColors.white)
                                Text(pickedNumber2 ?? "")
                                    .foregroundStyle(AppColors.black)
                                    .font(.system(size: 15))
                                    .onReceive(coordinator.$pickedNumber2) { phoneNumber in
                                        self.pickedNumber2 = phoneNumber
                                    }
                            }
                        } else {
                            ZStack{
                                Rectangle()
                                    .frame(width:.infinity, height:40)
                                    .foregroundColor(AppColors.gray04)
                                    .cornerRadius(17)
                                Image(systemName: "plus")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppColors.white)
                                Text(pickedNumber2 ?? "")
                                    .foregroundStyle(AppColors.black)
                                    .font(.system(size: 15))
                                    .onReceive(coordinator.$pickedNumber2) { phoneNumber in
                                        self.pickedNumber2 = phoneNumber
                                    }
                            }
                        }
                    }
                    
                    Button {
                        pickedNumber2 = nil
                        relation2 = ""
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width:36, height:36)
                                .foregroundColor(AppColors.gray03)
                            
                            Image(systemName: "trash")
                                .font(.system(size:15))
                                .foregroundColor(AppColors.white)
                        }
                    }
                }
                .padding(20)
                .frame(width: .infinity, height: 48)
                .cornerRadius(10)
                
                // 세 번째 연락처
                HStack(spacing: 10) {
                    
                    TextField("관계", text: $relation3)
                        .font(.system(size: 15))
                        .frame(width: 60, height:36)
                        .foregroundColor(AppColors.black)
                        .background(AppColors.gray04)
                        .cornerRadius(17)
                        .multilineTextAlignment(.center)
                        .onReceive(relation3.publisher.collect()) {
                            self.relation3 = String($0.prefix(10))
                        }
                    
                    Button {
                        openContactPicker(coordinator: coordinator, for: \.pickedNumber3)
                    } label: {
                        if pickedNumber3 == ""{
                            ZStack{
                                Rectangle()
                                    .frame(width:.infinity, height:40)
                                    .foregroundColor(AppColors.gray04)
                                    .cornerRadius(17)
                                Image(systemName: "plus")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppColors.white)
                                Text(pickedNumber3 ?? "")
                                    .foregroundStyle(AppColors.black)
                                    .font(.system(size: 15))
                                    .onReceive(coordinator.$pickedNumber3) { phoneNumber in
                                        self.pickedNumber3 = phoneNumber
                                    }
                            }
                        } else {
                            ZStack{
                                Rectangle()
                                    .frame(width:.infinity, height:40)
                                    .foregroundColor(AppColors.gray04)
                                    .cornerRadius(17)
                                Image(systemName: "plus")
                                    .font(.system(size: 15))
                                    .foregroundColor(AppColors.white)
                                Text(pickedNumber3 ?? "")
                                    .foregroundStyle(AppColors.black)
                                    .font(.system(size: 15))
                                    .onReceive(coordinator.$pickedNumber3) { phoneNumber in
                                        self.pickedNumber3 = phoneNumber
                                    }
                            }
                        }
                    }
                    
                    Button {
                        pickedNumber3 = nil
                        relation3 = ""
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width:36, height:36)
                                .foregroundColor(AppColors.gray03)
                            
                            Image(systemName: "trash")
                                .font(.system(size:15))
                                .foregroundColor(AppColors.white)
                        }
                    }
                }
                .padding(20)
                .frame(width: .infinity, height: 48)
                .cornerRadius(10)
                
                // 컴포넌트 끗
            }
        }
        .onAppear {
            let contacts = ContactsManager.shared.fetchContacts()
            if contacts.count >= 6 {
                pickedNumber = contacts[0]
                pickedNumber2 = contacts[1]
                pickedNumber3 = contacts[2]
                relation = contacts[3]
                relation2 = contacts[4]
                relation3 = contacts[5]
            }
        }
        .onDisappear(){ //데이지작성
            ContactsManager.shared.saveContacts(pickedNumber ?? "", pickedNumber2 ?? "", pickedNumber3 ?? "", relation, relation2, relation3, numOfRelation)
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
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first,
          let rootViewController = window.rootViewController else {
        print("Error: Could not get root view controller.")
        return
    }
    
    rootViewController.present(contactPicker, animated: true, completion: nil)
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
}

struct PatientContactEditor_Preview: PreviewProvider {
    @State static var numOfRelation: String = "0"
    
    static var previews: some View{
        PatientContactEditorView(numOfRelation: $numOfRelation)
    }
}
