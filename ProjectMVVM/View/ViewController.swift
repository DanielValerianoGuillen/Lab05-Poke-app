import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    	
    let pokeViewModel: PokeViewModel = PokeViewModel()
    
    var filterData:[Result]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
           await setUpdata()
        }
        setUpView()
    }
    
    func setUpdata() async{
        await pokeViewModel.getDataFromAPI()
        //print(pokeViewModel.pokemons)
        filterData=pokeViewModel.pokemons
        tableView.reloadData()
    }
    
    func setUpView(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    //Retorna el numero de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    // Setear los valores en la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let pokemon = filterData[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        cell.imageView?.image = HelperImage.setImage(id: HelperString.getIdFromUrl(url:pokemon.url))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filterData[indexPath.row].name)
    }
}

extension ViewController :UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData=searchText.isEmpty
        ? pokeViewModel.pokemons
        :pokeViewModel.pokemons.filter({(pokemon:Result)-> Bool in
            return pokemon.name.range(of: searchText,options: .caseInsensitive,range: nil,locale: nil) != nil
        })
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
//char
