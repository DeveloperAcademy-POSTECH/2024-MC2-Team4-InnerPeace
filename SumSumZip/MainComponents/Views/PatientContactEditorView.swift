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
        
        VStack(alignment: .leading){
            // 첫 번째 연락처
            HStack(spacing: 10) {
                Button {
                    openContactPicker(coordinator: coordinator, for: \.pickedNumber)
                } label: {
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
                
                Button {
                    pickedNumber = ""
                    relation = ""
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(AppColors.darkGreen)
                }
            }
            .padding(20)
            .frame(width: 360, height: 60)
            .background(AppColors.paleGreen)
            .cornerRadius(10)
            
            // 두 번째 연락처
            HStack(spacing: 10) {
                Button {
                    openContactPicker(coordinator: coordinator, for: \.pickedNumber2)
                } label: {
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
                
                Button {
                    pickedNumber2 = ""
                    relation2 = ""
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(AppColors.darkGreen)
                }
            }
            .padding(20)
            .frame(width: 360, height: 60)
            .background(AppColors.paleGreen)
            .cornerRadius(10)
            
            // 세 번째 연락처
            HStack(spacing: 10) {
                Button {
                    openContactPicker(coordinator: coordinator, for: \.pickedNumber3)
                } label: {
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
                
                Button {
                    pickedNumber3 = ""
                    relation3 = ""
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(AppColors.darkGreen)
                }
            }
            .padding(20)
            .frame(width: 360, height: 60)
            .background(AppColors.paleGreen)
            .cornerRadius(10)
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
