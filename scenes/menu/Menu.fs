namespace BloodFeverFs.Scene

type Menu() =
    inherit Base()

    member this.OnStartPressed() =
        this.SwitchTo("res://scenes/game/Diner.tscn")

    member this.OnAboutPressed() =
        this.SwitchTo("res://scenes/about/About.tscn")
