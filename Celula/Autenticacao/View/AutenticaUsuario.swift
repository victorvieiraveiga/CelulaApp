//
//  AutenticaUsuario.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 29/02/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
//import FirebaseAuth
//import Firebase


//class AutenticaUsuario: UIViewController {
//    
//    var mensagem: String = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    
//    
//    func logar (email: String, senha: String ) -> Bool {
//        let autenticacao = Auth.auth()//Auth.auth()
//        
//        do {
//            try autenticacao.signOut()
//        } catch  {
//            print ("Erro ao Deslogar.")
//        }
//        
//        var sucesso : Bool = true
//        autenticacao.signIn(withEmail: email, password: senha, completion: { (usuario, erro) in
//                        
//            if erro == nil {
//                    
//                    if usuario == nil {
//                        self.exibirMensagem (titulo: "Erro Autenticação", mensagem: "Tente novamente.")
//                    }else {
//                       self.exibirMensagem (titulo: "Sucesso", mensagem: "Usuario logado com sucesso.")
//                       sucesso =  true
//                    }
//                    
//                }else {
//                    self.exibirMensagem (titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente.")
//                   sucesso = false
//                }
//            }
//        )
////        signIn(withEmail: email, password: senha) { (usuario, erro) in
////             if erro == nil {
////
////                 if usuario == nil {
////                     self.exibirMensagem (titulo: "Erro Autenticação", mensagem: "Tente novamente.")
////                 }else {
////                    self.exibirMensagem (titulo: "Sucesso", mensagem: "Usuario logado com sucesso.")
////                    sucesso =  true
////                 }
////
////             }else {
////                 self.exibirMensagem (titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente.")
////                sucesso = false
////             }
////         }
//        return sucesso
//    }
//    
//
//    func CriaContaUsuario (email: String, senha: String) -> String{
//        
//        let autenticacao = Auth.auth()
//        
//        autenticacao.createUser(withEmail: email, password: senha, completion: { (usuario, erro) in
//            if erro == nil {
//                    //self.exibirMensagem(titulo: "Sucesso.", mensagem: "Sucesso ao cadastrar usuario.")
//                    self.mensagem = "Sucesso ao cadastrar usuario."
//                }else {
//                    let erroR = erro! as NSError
//                    if let codErro = erroR.localizedDescription as? String {
//                        let erroTexto = codErro
//                       //var mensagemErro = ""
//                        switch erroTexto {
//                        case "The email address is badly formatted." :
//                            self.mensagem = "E-mail Invalido, digite um e-mail valido!"
//                            break
//                        case "The password must be 6 characters long or more." :
//                            self.mensagem = "A senha precisa ter pelo menos 6 caracteres com letras e numeros."
//                            break
//                        case "ERROR_EMAIL_ALREADY_IN_USE" :
//                            self.mensagem = "Esse e-mail já esta sendo utilizado. Escolha outro e-mail."
//                            break
//                        default:
//                            self.mensagem = "Os dados digitados estão incorretos."
//                        }
//                        //self.exibirMensagem(titulo: "Dados Invalidos.", mensagem: mensagemErro)
//                    }
//                    //self.exibirMensagem(titulo: "Erro.", mensagem: "Erro ao cadastrar usuario.")
//                    self.mensagem = "Erro ao cadastrar usuario."
//                }
//            }
//        )
//        
//        
////        autenticacao.createUser(withEmail: email, password: senha) { (usuario, erro) in
////            if erro == nil {
////                //self.exibirMensagem(titulo: "Sucesso.", mensagem: "Sucesso ao cadastrar usuario.")
////                self.mensagem = "Sucesso ao cadastrar usuario."
////            }else {
////                let erroR = erro! as NSError
////                if let codErro = erroR.localizedDescription as? String {
////                    let erroTexto = codErro
////                   //var mensagemErro = ""
////                    switch erroTexto {
////                    case "The email address is badly formatted." :
////                        self.mensagem = "E-mail Invalido, digite um e-mail valido!"
////                        break
////                    case "The password must be 6 characters long or more." :
////                        self.mensagem = "A senha precisa ter pelo menos 6 caracteres com letras e numeros."
////                        break
////                    case "ERROR_EMAIL_ALREADY_IN_USE" :
////                        self.mensagem = "Esse e-mail já esta sendo utilizado. Escolha outro e-mail."
////                        break
////                    default:
////                        self.mensagem = "Os dados digitados estão incorretos."
////                    }
////                    //self.exibirMensagem(titulo: "Dados Invalidos.", mensagem: mensagemErro)
////                }
////                //self.exibirMensagem(titulo: "Erro.", mensagem: "Erro ao cadastrar usuario.")
////                self.mensagem = "Erro ao cadastrar usuario."
////            }
////        }
//        return self.mensagem
//    }
//    
//    func exibirMensagem (titulo: String, mensagem : String) {
//        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
//        let acaoCancelar = UIAlertAction (title: "Cancelar", style: .cancel, handler: nil)
//        
//        alerta.addAction(acaoCancelar)
//        present(alerta, animated: true, completion: nil)
//        
//    }
//}
