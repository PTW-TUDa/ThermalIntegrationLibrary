within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record OpaqueGlassWall = Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.OpaqueGlass(x=0.008),ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.VacuumInsulation(x=0.03),ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.OpaqueGlass(x=0.012)}, final nLay=3) "Construction with 8 mm ESG, 30 mm vacuum, 12 mm VSG"
        annotation (defaultComponentPrefixes="parameter",defaultComponentName="datOpaCon");
