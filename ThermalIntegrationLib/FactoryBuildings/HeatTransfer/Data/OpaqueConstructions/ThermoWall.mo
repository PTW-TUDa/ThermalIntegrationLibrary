within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record ThermoWall =   Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={HeatTransfer.Data.Solids.SheetSteel_60(x=0.0009),
        HeatTransfer.Data.Solids.RigidPURFoam_028(x=0.1),
        HeatTransfer.Data.Solids.SheetSteel_60(x=0.0009)}, final nLay=3)
        "Construction with 0.9 mm sheet steel, 100 mm rigid PUR foam, 0.9 mm sheet steel"
                                                                                    annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
