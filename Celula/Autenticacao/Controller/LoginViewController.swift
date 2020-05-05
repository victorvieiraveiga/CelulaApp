//
//  LoginViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 28/02/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

//import UIKit
//import FirebaseAuth
//
//
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var textEmail: UITextField!
//    @IBOutlet weak var textSenha: UITextField!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        verificaLogado ()
//    }
//    
//    
//    @IBAction func Logar(_ sender: Any) {
//        
//        if  let emailR = textEmail.text {
//            if let senhaR = textSenha.text {
//            
//                let autenticacao = Auth.auth()
//                
////                autenticacao?.signIn(withEmail: emailR, password: senhaR, completion: { (usuario, erro) in
////                      if erro == nil {
////
////                                          if usuario == nil {
////                                              self.exibirMensagem (titulo: "Erro Autenticação", mensagem: "Tente novamente.")
////                                          }else {
////                                              //self.exibirMensagem (titulo: "Sucesso", mensagem: "Usuario logado com sucesso.")
////
////                                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
////                                              let controller = storyboard.instantiateViewController(identifier: "tabBarId") as! TabBarViewController
////                                              self.present(controller, animated: true, completion: nil)
////
////                                              //self.navigationController?.pushViewController(controller, animated: true)
////                                              print ("Logado")
////                                          }
////
////                                      }else {
////                                          self.exibirMensagem (titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente.")
////                                      }
////                })
//                
//                autenticacao.signIn(withEmail: emailR, password: senhaR) { (usuario, erro) in
//                    if erro == nil {
//
//                        if usuario == nil {
//                            self.exibirMensagem (titulo: "Erro Autenticação", mensagem: "Tente novamente.")
//                        }else {
//                            //self.exibirMensagem (titulo: "Sucesso", mensagem: "Usuario logado com sucesso.")
//
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let controller = storyboard.instantiateViewController(identifier: "tabBarId") as! TabBarViewController
//                            self.present(controller, animated: true, completion: nil)
//
//                            //self.navigationController?.pushViewController(controller, animated: true)
//                            print ("Logado")
//                        }
//
//                    }else {
//                        self.exibirMensagem (titulo: "Dados incorretos", mensagem: "Verifique os dados digitados e tente novamente.")
//                    }
//                }
//            }
//        }
//        
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
//    
//    func verificaLogado () {
//        let autenticacao = Auth.auth()
//        
//        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
//            if usuario != nil {
//                self.vaiParaPrincipal ()
//            }
//        }
//    }
//    
//    func vaiParaPrincipal () {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(identifier: "tabBarId") as! TabBarViewController
//        self.present(controller, animated: true, completion: nil)
//       // self.navigationController?.pushViewController(controller, animated: true)
//        print ("Logado2")
//    }
//    
//}
