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
    @State private var password: String = ""
    @State private var showPassword = false
    @State private var rememberEmail = false
    @State private var showEmailError = false
    @State private var showResetPasswordAlert = false
    @State private var showResetConfirmation = false
    @State private var resetEmail: String = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Correo")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                
                TextField("Escriba aquí...", text: $email, onEditingChanged: { _ in
                    showEmailError = !email.isValidEmail && !email.isEmpty
                })
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(showEmailError ? Color.red : Color.gray, lineWidth: 1))
                .padding(.bottom, 2)
                
                Text("Correo Invalido")
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(showEmailError ? 1 : 0)
                
                Text("Ingresa tu contraseña")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                
                HStack {
                    Group {
                        if showPassword {
                            TextField("Escriba aquí...", text: $password)
                        } else {
                            SecureField("Escriba aquí...", text: $password)
                        }
                    }
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
                
                Toggle("Recordar correo", isOn: $rememberEmail)
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.top)
                
                Button("¿Olvidaste tu contraseña?") {
                    resetEmail = email
                    showResetPasswordAlert = true
                }
                .font(.subheadline)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .alert("Restablecer contraseña", isPresented: $showResetPasswordAlert, actions: {
                    TextField("Correo electrónico", text: $resetEmail)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                    
                    Button("Enviar") {
                        if resetEmail.isValidEmail {
                            showResetConfirmation = true
                        }
                    }
                    
                    Button("Cancelar", role: .cancel) { }
                }, message: {
                    Text("Ingresa tu correo para enviarte instrucciones")
                })
                .alert("Correo enviado", isPresented: $showResetConfirmation, actions: {
                    Button("OK", role: .cancel) { }
                }, message: {
                    Text("Se han enviado instrucciones a (resetEmail)")
                })
                
                Button(action: {
                    isLoading = true
                    session.login(with: email)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLoading = false
                    }
                }) {
                    Text("Iniciar sesión")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(email.isValidEmail && !password.isEmpty ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!email.isValidEmail || password.isEmpty)
                
                Picker("Modo de Apariencia", selection: $selectedThemeRawValue) {
                    ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                        Text(theme.label).tag(theme.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            .padding()
            .preferredColorScheme(AppTheme(rawValue: selectedThemeRawValue)?.colorScheme)
            
            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}

extension String {
    var isValidEmail: Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}



