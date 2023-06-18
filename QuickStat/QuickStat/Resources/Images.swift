//
//  Images.swift
//  QuickStat
//
//  Created by Nikita Kazakov on 09.04.2023.
//

import SwiftUI

struct Images {
    struct General {
        private static let path = "General/"
        
        static let testUser = Image(Self.path + "testUser")
        
        struct logo {
            private static let path = General.path + "Logo/"
            
            static let dota = Image(Self.path + "dota")
            static let steam = Image(Self.path + "steam")
        }
        
        struct checkmark {
            private static let path = General.path + "Checkmark/"
            
            static let circle = Image(Self.path + "circle")
        }
    }
    
    struct Heroes {
        private static let path = "Heroes/"
        
        static let abaddon = Image(Self.path + "abaddon")
        static let alchemist = Image(Self.path + "alchemist")
        static let ancientApparation = Image(Self.path + "ancient_apparation")
        static let antimage = Image(Self.path + "antimage")
        static let arcWarden = Image(Self.path + "arc_warden")
        static let axe = Image(Self.path + "axe")
        static let bane = Image(Self.path + "bane")
        static let batrider = Image(Self.path + "batrider")
        static let beastmaster = Image(Self.path + "beastmaster")
        static let bloodseeker = Image(Self.path + "bloodseeker")
        static let bountyHunter = Image(Self.path + "bounty_hunter")
        static let brewmaster = Image(Self.path + "brewmaster")
        static let bristleback = Image(Self.path + "bristleback")
        static let broodmother = Image(Self.path + "broodmother")
        static let centaur = Image(Self.path + "centaur")
        static let chaosKnight = Image(Self.path + "chaos_knight")
        static let chen = Image(Self.path + "chen")
        static let clinkz = Image(Self.path + "clinkz")
        static let crystalMaiden = Image(Self.path + "crystal_maiden")
        static let darkSeer = Image(Self.path + "dark_seer")
        static let dazzle = Image(Self.path + "dazzle")
        static let deathProphet = Image(Self.path + "death_prophet")
        static let disruptor = Image(Self.path + "disruptor")
        static let doom = Image(Self.path + "doom_bringer")
        static let dragonKnight = Image(Self.path + "dragon_knight")
        static let drowRanger = Image(Self.path + "drow_ranger")
        static let earthSpirit = Image(Self.path + "earth_spirit")
        static let earthshaker = Image(Self.path + "earthshaker")
        static let elderTitan = Image(Self.path + "elder_titan")
        static let emberSpirit = Image(Self.path + "ember_spirit")
        static let enchantress = Image(Self.path + "enchantress")
        static let enigma = Image(Self.path + "enigma")
        static let facelessVoid = Image(Self.path + "facelessVoid")
        static let furion = Image(Self.path + "furion")
        static let gyrocopter = Image(Self.path + "gyrocopter")
        static let huskar = Image(Self.path + "huskar")
        static let invoker = Image(Self.path + "invoker")
        static let jakiro = Image(Self.path + "jakiro")
        static let juggernaut = Image(Self.path + "juggernaut")
        static let keeperOfTheLight = Image(Self.path + "keeper_of_the_light")
        static let kunkka = Image(Self.path + "kunkka")
        static let legionCommander = Image(Self.path + "legion_commander")
        static let leshrak = Image(Self.path + "leshrak")
        static let lich = Image(Self.path + "lich")
        static let lifeStealer = Image(Self.path + "life_stealer")
        static let lina = Image(Self.path + "lina")
        static let loneDruid = Image(Self.path + "lone_druid")
        static let morphling = Image(Self.path + "morphling")
        static let nagaSiren = Image(Self.path + "naga_siren")
        static let necrophose = Image(Self.path + "necrolyte")
        static let shadowFiend = Image(Self.path + "nevermore")
        static let nightStalker = Image(Self.path + "night_stalker")
        static let nyxAssassin = Image(Self.path + "nyx_assassin")
        static let od = Image(Self.path + "obsidian_destroyer")
        static let ogreMagi = Image(Self.path + "ogre_magi")
        static let omniknight = Image(Self.path + "omniknight")
        static let oracle = Image(Self.path + "oracle")
        static let phantomAssassin = Image(Self.path + "phantom_assassin")
        static let phantomLancer = Image(Self.path + "phantom_lancer")
        static let phoenix = Image(Self.path + "phoenix")
        static let puck = Image(Self.path + "puck")
        static let pudge = Image(Self.path + "pudge")
        static let pugna = Image(Self.path + "pugna")
        static let queenOfPain = Image(Self.path + "queenofpain")
        static let clockwerk = Image(Self.path + "rattletrap")
        static let razor = Image(Self.path + "razor")
        static let riki = Image(Self.path + "riki")
        static let rubick = Image(Self.path + "rubick")
        static let sandKing = Image(Self.path + "sand_king")
        static let shadowDemon = Image(Self.path + "shadow_demon")
        static let shadowShaman = Image(Self.path + "shadow_shaman")
        static let timbersaw = Image(Self.path + "shredder")
        static let silencer = Image(Self.path + "silencer")
        static let wraithKing = Image(Self.path + "skeleton_king")
        static let skywrathMage = Image(Self.path + "skywrath_mage")
        static let slardar = Image(Self.path + "slardar")
        static let slark = Image(Self.path + "slark")
        static let sniper = Image(Self.path + "sniper")
        static let spectre = Image(Self.path + "spectre")
        static let spiritBreaker = Image(Self.path + "spirit_breaker")
        static let stormSpirit = Image(Self.path + "storm_spirit")
        static let sven = Image(Self.path + "sven")
        static let techies = Image(Self.path + "techies")
        static let templarAssassin = Image(Self.path + "templar_assassin")
        static let terrorblade = Image(Self.path + "terrorblade")
        static let tidehunter = Image(Self.path + "tidehunter")
        static let tinker = Image(Self.path + "tinker")
        static let tiny = Image(Self.path + "tiny")
        static let treant = Image(Self.path + "treant")
        static let troll = Image(Self.path + "troll_warlord")
        static let tusk = Image(Self.path + "tusk")
        static let undying = Image(Self.path + "undying")
        static let ursa = Image(Self.path + "ursa")
        static let venga = Image(Self.path + "vengefulspirit")
        static let venomancer = Image(Self.path + "venomancer")
        static let viper = Image(Self.path + "viper")
        static let visage = Image(Self.path + "visage")
        static let warlock = Image(Self.path + "warlock")
        static let weaver = Image(Self.path + "weaver")
        static let windrunner = Image(Self.path + "windrunner")
        static let winterWyvern = Image(Self.path + "winter_wyvern")
        static let io = Image(Self.path + "wisp")
        static let witchDoctor = Image(Self.path + "witch_doctor")
        static let zeus = Image(Self.path + "zuus")
    }
}
