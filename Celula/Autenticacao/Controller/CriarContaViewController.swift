//
//  CriarContaViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 28/02/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

//import UIKit
//import FirebaseAuth
//import Firebase
//
//class CriarContaViewController: UIViewController {
//
//   
//
//    @IBOutlet weak var textEmail: UITextField!
//    @IBOutlet weak var textSenha: UITextField!
//    @IBOutlet weak var textConfirmaSenha: UITextField!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
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
//    @IBAction func criarConta(_ sender: Any) {
//        
//            if let email = textEmail.text {
//                if let senha = textSenha.text {
//                    if let senhaConfirmada = textConfirmaSenha.text {
//                        // Validar Senha
//                        if senha == senhaConfirmada {
//                            
//                            let autenticacao = Auth.auth()
//                            autenticacao.createUser(withEmail: email, password: senha) { (usuario, erro) in
//                                if erro == nil {
//                                    self.exibirMensagem(titulo: "Sucesso.", mensagem: "Sucesso ao cadastrar usuario.")
//                                    
//                                    self.vaiParaPrincipal ()
//                                    
//                                }else {
//                                    let erroR = erro! as NSError
//                                    if let codErro = erroR.localizedDescription as? String {
//                                        let erroTexto = codErro
//                                        var mensagemErro = ""
//
//                                        switch erroTexto {
//                                        case "The email address is badly formatted." :
//                                            mensagemErro = "E-mail Invalido, digite um e-mail valido!"
//                                            break
//                                        case "The password must be 6 characters long or more." :
//                                            mensagemErro = "A senha precisa ter pelo menos 6 caracteres com letras e numeros."
//                                            break
//                                        case "The email address is already in use by another account." :
//                                            mensagemErro = "Esse e-mail já esta sendo utilizado. Escolha outro e-mail."
//                                            break
//                                        default:
//                                            mensagemErro = "Os dados digitados estão incorretos."
//                                        }
//                                        self.exibirMensagem(titulo: "Dados Invalidos.", mensagem: mensagemErro)
//                                    }
//                                    self.exibirMensagem(titulo: "Erro.", mensagem: "Erro ao cadastrar usuario.")
//                                }
//                            }
//                            
//                        } else {
//                            exibirMensagem(titulo: "Dados Incorretos.", mensagem: "As senhas não estão iguais. Digite novamente.")
//                        }//Fim valida senha
//                    }
//                }
//        }
//        
//    }
//    
//    func vaiParaPrincipal () {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(identifier: "tabBarId") as! TabBarViewController
//        self.navigationController?.pushViewController(controller, animated: true)
//        print ("Logado2")
//    }
//    
//}
