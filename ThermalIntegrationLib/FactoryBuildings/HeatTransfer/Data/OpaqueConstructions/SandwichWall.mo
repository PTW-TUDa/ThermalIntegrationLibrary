within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record SandwichWall = Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={HeatTransfer.Data.Solids.SheetSteel_60(x=0.0009),HeatTransfer.Data.Solids.RigidPURFoam_028(x=0.08),
        HeatTransfer.Data.Solids.SheetSteel_60(x=0.0009)}, final nLay=3)
  "Construction with 0.9 mm sheet steel, 80 mm rigid PUR foam, 0.9 mm sheet steel" annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
