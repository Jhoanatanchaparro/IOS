//
//  LoginView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 29/07/25.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("appTheme") private var selectedThemeRawValue: String = AppTheme.system.rawValue
    @EnvironmentObject var session: SessionManager
    @State private var email: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Bienvenido")
                .font(.largeTitle)
                .bold()
            
            TextField("Ingresa tu correo electrónico", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if showError && !isValidEmail(email) {
                Text("Por favor ingresa un correo válido")
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal)
            }

            Button(action: {
                if isValidEmail(email) {
                    session.login(with: email)
                    showError = false
                } else {
                    showError = true
                }
            }) {
                Text("Iniciar Sesión")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding()
        
        Picker("Modo de Apariencia", selection: $selectedThemeRawValue) {
            ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                Text(theme.label).tag(theme.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}

