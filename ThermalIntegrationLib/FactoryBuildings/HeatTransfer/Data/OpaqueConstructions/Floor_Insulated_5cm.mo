within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Floor_Insulated_5cm = Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.ExtrudedPolystyrene(x=0.05),ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.PE_Foil_033(x=0.0003),ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.ConcreteReinf2pc(x=0.2)}, final nLay=3) "Construction with 50 mm XPS, 0.3 mm PE Foil, 200 mm reinforced concrete"
        annotation (defaultComponentPrefixes="parameter",defaultComponentName="datOpaCon");
