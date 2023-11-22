within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record CassetteWall120 =
                      Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.SheetSteel_50(
                                                                                                                                                 x=0.0015),
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.MineralWool_035(
                                                                  x=0.12),ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.SheetSteel_50(
                                                                                                                                  x=0.0015)}, final nLay=3) "Construction with 1.5 mm sheet steel, 120 mm mineral wool, 1.5 mm sheet steel"
                                                                                  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
