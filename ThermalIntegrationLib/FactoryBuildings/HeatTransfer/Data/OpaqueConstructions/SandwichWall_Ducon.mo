within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record SandwichWall_Ducon =
                      Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={HeatTransfer.Data.Solids.DUCON(x=0.050),HeatTransfer.Data.Solids.MineralWool_035(x=0.100),
        HeatTransfer.Data.Solids.DUCON(x=0.050)}, final nLay=3) "Construction with 50 mm DUCON, 100 mm rigid PUR foam, 50 mm DUCON"
                                                                                    annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
