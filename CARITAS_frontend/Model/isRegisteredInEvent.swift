//
//  isRegisteredInEvent.swift
//  CARITAS_frontend
//
//  Created by Alumno on 23/09/24.
//

import Foundation

// Esta función determina si el usuario en cuestión está registrado en un evento

func verificarRegistro(idUsuario: Int, tituloEvento: String, completion: @escaping (Bool) -> Void) {
    // EndPoint de la API
    let urlString = "http://10.14.255.65:10206/\(idUsuario)/mis-eventos"
    
    // El guard solo continúa la ejecución de esta función si la URL es válida
    // Intenta establecer el valor de la variable url. Si lo consigue, prosigue,
    // sino, imprime un mensaje de error y termina la ejecución.
    guard let url = URL(string: urlString) else {
        print("URL inválida")
        completion(false)
        return
    }
    
    // Solicitud GET de la API
    let task = URLSession.shared.dataTask(with: url)    { data, response, error in
        if let error = error {
            print("Error en la solicitud: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        guard let data = data else {
            print("No se recibió la respuesta")
            completion(false)
            return
        }
        
        do {
            // Aquí se convierten los datos recibidos en un arreglo de Strings que representan los títulos de los eventos
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                // Verificamos si el título de nuestro evento está en la lista de títulos recopilados de la API
                // Modificamos isRegistered
                let isRegistered = json.contains(tituloEvento)
                
                // Llamamos al closure de completion con el resultado
                completion(isRegistered)
            } else {
                print("Formato de datos inválido")
                completion(false)
            }
        } catch {
            print("Error al parsear la respuesta JSON: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // Iniciamos la solicitud GET
    task.resume()
}
