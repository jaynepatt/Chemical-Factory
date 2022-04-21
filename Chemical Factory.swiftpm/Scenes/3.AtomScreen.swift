//
//  File.swift
//  
//
//  Created by Daniella Onishi on 21/04/22.
//

import Foundation
import SpriteKit

class AtomScreen: SKScene {
    var lightPoint: SKLightNode!
    var dragging: SKSpriteNode?
    var originalDraggingPosition: CGPoint?
    var zTop: CGFloat = 1
    var protonItem: SKSpriteNode!
    var neutronItem: SKSpriteNode!
    var eletronItem: SKSpriteNode!
    var nucleoItem: SKSpriteNode!
    var protons: [SKSpriteNode]!
    var neutrons: [SKSpriteNode]!
    var eletrons: [SKSpriteNode]!
    var nucleus: [SKSpriteNode]!
    var fullAtom: SKNode!
    var hitBox: SKSpriteNode!
    var popUp: SKSpriteNode!
    var imageList: [SKSpriteNode]!
    var magicalWand: SKSpriteNode!
    
    private var animation: SKAction!
    
    override func didMove(to view: SKView) {
        
        popUp = (childNode(withName: "Talk Balone With Witch") as! SKSpriteNode)
        
        lightPoint = (childNode(withName: "LightPoint") as! SKLightNode)
        lightPoint.isEnabled = true
        animateLightNode()
        
        fullAtom = (childNode(withName: "Full Atom") as! SKNode)
        hitBox = (childNode(withName: "Hit Box") as! SKSpriteNode)
        magicalWand = (childNode(withName: "Magical Wand") as! SKSpriteNode)
        
        protonItem = (childNode(withName: "Proton") as! SKSpriteNode)
        neutronItem = (childNode(withName: "Neutron") as! SKSpriteNode)
        eletronItem = (childNode(withName: "Eletron") as! SKSpriteNode)
        nucleoItem = (childNode(withName: "Nucleo") as! SKSpriteNode)

        imageList = [protonItem, neutronItem, eletronItem, nucleoItem]
        
        for image in imageList {
            image.alpha = 0
        }
        
        protons = fullAtom.children.filter({ $0.name == "proton" }).compactMap({ $0 as? SKSpriteNode })
        neutrons = fullAtom.children.filter({ $0.name == "neutron" }).compactMap({ $0 as? SKSpriteNode })
        eletrons = fullAtom.children.filter({ $0.name?.starts(with: "eletron") ?? false }).compactMap({ $0 as? SKSpriteNode })
        nucleus = fullAtom.children.filter({ $0.name == "nucleo" }).compactMap({ $0 as? SKSpriteNode })
        
        let duration: CGFloat = 1.5
        fullAtom.childNode(withName: "eletron-1")?.run(.sequence([
            .repeatForever(
                .sequence([
                    .move(to: .zero, duration: 0),
                    .follow(
                        CGPath(
                            ellipseIn: CGRect(x: -80, y: -35, width: 160, height: 70),
                            transform: nil
                        ),
                        duration: duration),
                ])
            )
        ]))
        
        var transform2 = CGAffineTransform(rotationAngle: .pi / 4)
        fullAtom.childNode(withName: "eletron-2")?.run(.sequence([
            .wait(forDuration: duration/2),
            .repeatForever(
                .sequence([
                    .move(to: .zero, duration: 0),
                    .follow(
                        CGPath(
                            ellipseIn: CGRect(x: -80, y: -35, width: 160, height: 70),
                            transform: &transform2
                        ),
                        duration: duration),
                ])
            )
        ]))
        
        var transform3 = CGAffineTransform(rotationAngle: .pi / 4 * 3)
        fullAtom.childNode(withName: "eletron-3")?.run(.sequence([
            .repeatForever(
                .sequence([
                    .move(to: .zero, duration: 0),
                    .follow(
                        CGPath(
                            ellipseIn: CGRect(x: -80, y: -35, width: 160, height: 70),
                            transform: &transform3
                        ),
                        duration: duration),
                ])
            )
        ]))

        fullAtom.childNode(withName: "eletron-4")?.run(.sequence([
            .wait(forDuration: duration/6),
            .repeatForever(
                .sequence([
                    .move(to: .zero, duration: 0),
                    .follow(
                        CGPath(
                            ellipseIn: CGRect(x: -35, y: -80, width: 70, height: 160),
                            transform: nil
                        ),
                        duration: duration),
                ])
            )
        ]))
        
    }
    
    func showNodes(nodes: [SKSpriteNode]) {
        for node in nodes {
            node.alpha = 1
        }
    }
    
    func animateLightNode() {
        let minimumOpacity: CGFloat = 0.5
        let opacityDelta = 1 - minimumOpacity
        let duration: CGFloat = 1.5
        
        let lightColor = lightPoint.lightColor
        
        lightPoint.run(.repeatForever(.sequence([
            // light up
            .customAction(withDuration: duration, actionBlock: { node, delta in
                guard let node = node as? SKLightNode else { return }
                node.lightColor = lightColor.withAlphaComponent(minimumOpacity + opacityDelta * (delta / duration))
            }),
            // light down
            .customAction(withDuration: duration, actionBlock: { node, delta in
                guard let node = node as? SKLightNode else { return }
                node.lightColor = lightColor.withAlphaComponent(1 - opacityDelta * (delta / duration))
            })
        ])))
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        for imagem in imageList {
            if imagem.contains(pos) {
                dragging = imagem
                originalDraggingPosition = imagem.position
                imagem.setScale(1.15)
                imagem.zPosition = zTop
                zTop += 1
                return
            }
        }
        
        if magicalWand.contains(pos) {
            for image in imageList {
                image.alpha = 1
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        dragging?.setScale(1)
        if let originalDraggingPosition = originalDraggingPosition {
            dragging?.position = originalDraggingPosition
        }
        if hitBox.contains(pos) {
            if dragging?.name == protonItem.name {
                showNodes(nodes: protons)
                popUp.texture = SKTexture(imageNamed: "Talk Balone With Witch")
            } else if dragging?.name == neutronItem.name {
                showNodes(nodes: neutrons)
                popUp.texture = SKTexture(imageNamed: "Talk Balone With Witch")
            } else if dragging?.name == nucleoItem.name {
                showNodes(nodes: nucleus)
                popUp.texture = SKTexture(imageNamed: "Talk Balone With Witch")
            } else if dragging?.name == eletronItem.name {
                showNodes(nodes: eletrons)
                popUp.texture = SKTexture(imageNamed: "Talk Balone With Witch")
            }
            dragging = nil
        }
    }
        
    func touchMoved(atPoint pos : CGPoint) {
        dragging?.position = pos
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    
}
