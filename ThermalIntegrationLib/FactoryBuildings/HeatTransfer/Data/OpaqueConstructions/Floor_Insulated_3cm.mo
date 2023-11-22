within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Floor_Insulated_3cm =
                      Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={HeatTransfer.Data.Solids.ConcreteReinf2pc(x=0.2),HeatTransfer.Data.Solids.MineralWool_035(x=0.03),
        HeatTransfer.Data.Solids.Screed(x=0.062)}, final nLay=3) "Construction with 200 mm reinforced concrete, 30 mm mineral wool 035, 62 mm floor screed"
                                                                                    annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
