import UIKit

class ViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AppDelegate.shared().authService
    }
    
    @IBAction func signIButtonPressed(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}
