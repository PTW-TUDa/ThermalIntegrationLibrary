within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Ceiling_Insulated =
                  Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={
                  ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.SheetSteel_50( x=0.00075),
                  ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.PA_Foil(x=0.001),
                  ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.MineralWool_040(x=0.12),
                  ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids.PE_Foil_017(x=0.002)},
        final nLay=4) "Construction with 0.75 mm Trapezblech, 1 mm PA Foil, 120 mm whool, 2 mm PVC"
        annotation (defaultComponentPrefixes="parameter",defaultComponentName="datOpaCon");
