within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record SheetSteel_50 = Buildings.HeatTransfer.Data.Solids.Generic (
    k=50,
    d=7100,
    c=480) "Sheet steel"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
