within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Concrete_Insulated =
                  Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.MineralWool_035(x=0.1),
        ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.ConcreteReinf2pc(x=0.2)},
        final nLay=2) "Construction with 100 mm mineral wool 035, 200 mm reinforced concrete"
        annotation (defaultComponentPrefixes="parameter",defaultComponentName="datOpaCon");
