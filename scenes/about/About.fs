namespace BloodFeverFs.Scene

type About() =
    inherit Base()

    member this.OnAboutPressed() =
        this.SwitchTo("res://scenes/menu/Menu.tscn")
