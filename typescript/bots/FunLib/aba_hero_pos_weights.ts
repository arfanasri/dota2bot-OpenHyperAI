import { HeroName } from "bots/ts_libs/dota/heroes";
type HeroPositionMap = {
    [key: string]: number[];
};

const HeroPositions: HeroPositionMap = {
    [HeroName.Abaddon]: [25, 5, 30, 20, 50],
    [HeroName.Underlord]: [5, 20, 80, 5, 0],
    [HeroName.Alchemist]: [50, 30, 15, 5, 0],
    [HeroName.AncientApparition]: [5, 25, 10, 30, 50],
    [HeroName.Antimage]: [90, 5, 5, 0, 0],
    [HeroName.ArcWarden]: [30, 60, 5, 5, 0],
    [HeroName.Axe]: [30, 5, 80, 5, 0],
    [HeroName.Bane]: [0, 20, 10, 30, 40],
    [HeroName.Batrider]: [5, 60, 30, 5, 0],
    [HeroName.Beastmaster]: [5, 45, 65, 5, 0],
    [HeroName.Bloodseeker]: [45, 40, 35, 0, 0],
    [HeroName.BountyHunter]: [0, 45, 30, 50, 35],
    [HeroName.Brewmaster]: [5, 15, 85, 5, 0],
    [HeroName.Bristleback]: [30, 30, 60, 0, 0],
    [HeroName.Broodmother]: [15, 60, 30, 5, 0],
    [HeroName.Centaur]: [5, 5, 85, 5, 0],
    [HeroName.ChaosKnight]: [55, 40, 25, 0, 0],
    [HeroName.Chen]: [0, 5, 10, 15, 20],
    [HeroName.Clinkz]: [40, 45, 5, 10, 0],
    [HeroName.CrystalMaiden]: [0, 5, 10, 30, 55],
    [HeroName.DarkSeer]: [5, 5, 80, 10, 0],
    [HeroName.DarkWillow]: [0, 20, 10, 30, 25],
    [HeroName.Dawnbreaker]: [5, 20, 75, 10, 0],
    [HeroName.Dazzle]: [0, 45, 10, 30, 55],
    [HeroName.DeathProphet]: [5, 60, 40, 5, 0],
    [HeroName.Disruptor]: [0, 5, 10, 30, 55],
    [HeroName.Doom]: [5, 15, 85, 5, 0],
    [HeroName.DragonKnight]: [55, 70, 35, 10, 0],
    [HeroName.DrowRanger]: [70, 35, 5, 0, 0],
    [HeroName.EarthSpirit]: [0, 5, 30, 70, 15],
    [HeroName.Earthshaker]: [0, 5, 35, 70, 15],
    [HeroName.ElderTitan]: [0, 5, 20, 30, 15],
    [HeroName.EmberSpirit]: [15, 70, 15, 0, 0],
    [HeroName.Enchantress]: [0, 5, 10, 35, 50],
    [HeroName.Enigma]: [0, 35, 55, 30, 0],
    [HeroName.FacelessVoid]: [60, 0, 25, 5, 0],
    [HeroName.NaturesProphet]: [45, 25, 50, 40, 0],
    [HeroName.Grimstroke]: [0, 5, 10, 35, 50],
    [HeroName.Gyrocopter]: [60, 5, 25, 20, 10],
    [HeroName.Hoodwink]: [0, 5, 10, 25, 20],
    [HeroName.Huskar]: [35, 50, 35, 0, 0],
    [HeroName.Invoker]: [30, 50, 10, 30, 0],
    [HeroName.Jakiro]: [0, 35, 30, 30, 55],
    [HeroName.Juggernaut]: [80, 15, 15, 0, 0],
    [HeroName.KeeperOfTheLight]: [0, 15, 10, 40, 40],
    [HeroName.Kunkka]: [35, 85, 35, 5, 0],
    [HeroName.LegionCommander]: [5, 35, 65, 5, 0],
    [HeroName.Leshrac]: [5, 30, 25, 25, 20],
    [HeroName.Lich]: [0, 35, 10, 50, 50],
    [HeroName.Lifestealer]: [30, 5, 30, 0, 0],
    [HeroName.Lina]: [25, 50, 5, 20, 30],
    [HeroName.Lion]: [30, 45, 10, 30, 45],
    [HeroName.LoneDruid]: [20, 25, 15, 0, 0],
    [HeroName.Luna]: [70, 5, 15, 0, 0],
    [HeroName.Lycan]: [45, 45, 45, 5, 0],
    [HeroName.Magnus]: [5, 15, 85, 5, 0],
    [HeroName.Marci]: [0, 5, 20, 20, 15],
    [HeroName.Mars]: [5, 55, 55, 5, 0],
    [HeroName.Medusa]: [50, 65, 5, 0, 0],
    [HeroName.Meepo]: [20, 20, 5, 0, 0],
    [HeroName.Mirana]: [0, 65, 10, 65, 20],
    [HeroName.MonkeyKing]: [50, 35, 45, 0, 0],
    [HeroName.Morphling]: [20, 15, 5, 0, 0],
    [HeroName.Muerta]: [35, 5, 5, 15, 5],
    [HeroName.NagaSiren]: [70, 5, 15, 0, 0],
    [HeroName.Necrophos]: [5, 60, 30, 5, 0],
    [HeroName.ShadowFiend]: [15, 80, 5, 0, 0],
    [HeroName.NightStalker]: [5, 25, 65, 25, 0],
    [HeroName.NyxAssassin]: [0, 5, 40, 65, 20],
    [HeroName.Ringmaster]: [5, 20, 5, 50, 20],
    [HeroName.OutworldDestroyer]: [5, 90, 5, 0, 0],
    [HeroName.OgreMagi]: [30, 45, 30, 30, 45],
    [HeroName.Omniknight]: [40, 5, 50, 30, 55],
    [HeroName.Oracle]: [0, 35, 10, 30, 45],
    [HeroName.Pangolier]: [5, 25, 15, 5, 0],
    [HeroName.PhantomAssassin]: [90, 5, 5, 0, 0],
    [HeroName.PhantomLancer]: [90, 5, 5, 0, 0],
    [HeroName.Phoenix]: [0, 35, 30, 65, 20],
    [HeroName.PrimalBeast]: [5, 5, 25, 5, 0],
    [HeroName.Puck]: [5, 70, 25, 10, 10],
    [HeroName.Pudge]: [5, 35, 50, 25, 5],
    [HeroName.Pugna]: [0, 35, 20, 65, 20],
    [HeroName.QueenOfPain]: [25, 50, 25, 20, 0],
    [HeroName.Clockwerk]: [5, 5, 55, 35, 10],
    [HeroName.Razor]: [5, 85, 5, 5, 0],
    [HeroName.Riki]: [55, 10, 20, 15, 10],
    [HeroName.Rubick]: [0, 35, 20, 40, 45],
    [HeroName.SandKing]: [5, 35, 65, 25, 0],
    [HeroName.ShadowDeamon]: [0, 5, 10, 30, 55],
    [HeroName.ShadowShaman]: [0, 10, 0, 45, 55],
    [HeroName.Timbersaw]: [5, 25, 65, 5, 0],
    [HeroName.Silencer]: [10, 55, 10, 30, 35],
    [HeroName.WraithKing]: [50, 5, 45, 0, 0],
    [HeroName.SkywrathMage]: [0, 45, 10, 65, 20],
    [HeroName.Slardar]: [35, 5, 55, 5, 0],
    [HeroName.Slark]: [90, 5, 5, 0, 0],
    [HeroName.Snapfire]: [20, 35, 30, 60, 15],
    [HeroName.Sniper]: [70, 65, 5, 0, 0],
    [HeroName.Spectre]: [70, 5, 5, 0, 0],
    [HeroName.SpiritBreaker]: [0, 5, 50, 50, 15],
    [HeroName.StormSpirit]: [25, 30, 5, 0, 0],
    [HeroName.Sven]: [60, 5, 35, 0, 0],
    [HeroName.Techies]: [10, 35, 20, 40, 15],
    [HeroName.TemplarAssassin]: [5, 90, 5, 0, 0],
    [HeroName.Terrorblade]: [90, 5, 5, 0, 0],
    [HeroName.Tidehunter]: [25, 25, 45, 5, 0],
    [HeroName.Tinker]: [5, 15, 5, 20, 0],
    [HeroName.Tiny]: [5, 25, 65, 5, 0],
    [HeroName.TreantProtector]: [0, 5, 10, 30, 55],
    [HeroName.TrollWarlord]: [90, 5, 25, 0, 0],
    [HeroName.Tusk]: [0, 20, 35, 40, 15],
    [HeroName.Undying]: [0, 5, 30, 30, 55],
    [HeroName.Ursa]: [50, 25, 25, 0, 0],
    [HeroName.VengefulSpirit]: [0, 5, 10, 30, 55],
    [HeroName.Venomancer]: [25, 55, 45, 25, 20],
    [HeroName.Viper]: [45, 55, 45, 5, 0],
    [HeroName.Visage]: [5, 15, 25, 5, 0],
    [HeroName.VoidSpirit]: [15, 30, 15, 0, 0],
    [HeroName.Warlock]: [0, 35, 0, 40, 55],
    [HeroName.Weaver]: [35, 15, 10, 45, 15],
    [HeroName.Windrunner]: [5, 45, 45, 5, 0],
    [HeroName.WinterWyvern]: [0, 35, 10, 20, 25],
    [HeroName.IO]: [0, 5, 10, 25, 20],
    [HeroName.WitchDoctor]: [0, 5, 10, 35, 55],
    [HeroName.Zeus]: [25, 60, 15, 40, 20],
    [HeroName.Kez]: [40, 45, 5, 0, 0],
};

export function GetHeroPositions(): HeroPositionMap {
    return HeroPositions;
}
