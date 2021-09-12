import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?

    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.authService = AuthService()
        authService.delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    // MARK:- AuthServiceDelegate
    func authServiceShouldShow(_ viewController: UIViewController) {
        window?.rootViewController?.present(viewController,animated: true,completion: nil)
    }
    
    func authServiceSignIn() {
        let feedVC = UIStoryboard(name: "NewsFeedViewController", bundle: nil).instantiateInitialViewController() as! NewsFeedViewController
        let navVc = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVc
    }
    
    func authServiceDidSignInFail() {
        
    }
}
