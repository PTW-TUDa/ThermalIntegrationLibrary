within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record InteriourWall_GypsumBoard =
                      Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (
material={Buildings.HeatTransfer.Data.Solids.GypsumBoard(x=0.01),
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.MineralWool_035(x=0.04),
        Buildings.HeatTransfer.Data.Solids.GypsumBoard(x=0.01)}, final nLay=3) "Construction with 10 mm GypsumBoard, 40 mm Isolation, 10 mm GypsumBoard"
                                                                                  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
