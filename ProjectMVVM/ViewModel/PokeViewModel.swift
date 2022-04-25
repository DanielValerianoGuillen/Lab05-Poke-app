import Foundation

class PokeViewModel {
    
    var pokemons = [Result]()
    let URL_API:String = "https://pokeapi.co/api/v2/pokemon"
    //Funcion sincrona
     func getDataFromAPI() async {
        guard let url = URL(string: URL_API) else {return}
         do{
             let(data,_)=try await URLSession.shared.data(from: url)
             if let decoder = try? JSONDecoder().decode(Pokemon.self, from: data){
                 DispatchQueue.main.async(execute: {
                     decoder.results.forEach{
                         pokemon in self.pokemons.append(pokemon)
                     }
                 })
             }
         }catch{
             print("error found")
         }
    }
}
    
    
    
    //Esta funcion es asincrono :(
//    func getDataFromAPI() {
  //      guard let url = URL(string: URL_API) else {return}
        	
    //   let task=URLSession.shared.dataTask(with: url) { data,  response, error in
     //      if let data = data {
     //           let decode=String(data:data,encoding: .utf8)
       //         print(decode!)
   //         }
    //    }
   //     task.resume()
   // }
   

