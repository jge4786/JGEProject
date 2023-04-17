import UIKit
import Chat
import Dalla

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let chatViewController = ChatRoomListViewController()
        let gptViewController = ChatRoomListViewController()
        let dallaViewController = DallaViewController()
        let tabBarController = MyProjectTabBarController()
        let firstNavController = UINavigationController(rootViewController: chatViewController)
        let secondNavController = UINavigationController(rootViewController: gptViewController)
        let thirdNavController = UINavigationController(rootViewController: dallaViewController)
        
        tabBarController.viewControllers = [firstNavController, secondNavController, thirdNavController]
        
        firstNavController.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "xmark"), tag: 0)
        secondNavController.tabBarItem = UITabBarItem(title: "GPT", image: UIImage(systemName: "ellipsis"), tag: 1)
        thirdNavController.tabBarItem = UITabBarItem(title: "Dalla", image: UIImage(systemName: "circle"), tag: 2)
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
