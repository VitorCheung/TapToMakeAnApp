//
//  ManegerGamerCenter.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 25/01/22.
//

import Foundation
import GameKit


class ManagerGameCenter: GKGameCenterViewController, GKGameCenterControllerDelegate {
    
    static func authenticateUser(from:UIViewController) -> Void {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if (vc == nil && error == nil) {
                return
            }
            guard error == nil else { return }
            
            from.present(vc!, animated: true, completion: nil)
        }
    }
    
    static func showAvatarGameCenter(isVisible:Bool) -> Void {
        if (GKLocalPlayer.local.isAuthenticated) {
            GKAccessPoint.shared.location = .topTrailing
            GKAccessPoint.shared.showHighlights = false
            GKAccessPoint.shared.isActive = isVisible
        }
    }
    
    static func setHighScore(score:Int64) -> Void {
        if (GKLocalPlayer.local.isAuthenticated) {
            GKLeaderboard.submitScore(Int(score), context: 0,
                                      player: GKLocalPlayer.local,
                                      leaderboardIDs: ["leaderboard"],
                                      completionHandler:{error in}
            )
        }
    }
    
//    static func getHighScoreFromLeadboard(label:UILabel) -> Void {
//        if (GKLocalPlayer.local.isAuthenticated) {
//            GKLeaderboard.loadLeaderboards(IDs: ["lucaHummel.CreamTower.Scores"]) { leaderboards, _ in
//                leaderboards?[0].loadEntries(for: [GKLocalPlayer.local], timeScope: .allTime) {
//                    player, _, _ in
//                    UserDefaults.standard.set(player?.score, forKey: "HighScore")
//                    print(String(UserDefaults.standard.integer(forKey: "HighScore")))
//                }
//            }
//        }
//    }
            
    public func toSpecificPage(from:UIViewController, to:GKGameCenterViewControllerState) -> Bool {
        if (GKLocalPlayer.local.isAuthenticated) {
            let viewController = GKGameCenterViewController(
                            leaderboardID: "leaderboard",
                            playerScope: .global,
                            timeScope: .allTime)
            viewController.gameCenterDelegate = self
            from.present(viewController, animated: true, completion: nil)
            return true
        }; return false
    }

    
    /* MARK: - Delegate */

    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) -> Void {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
