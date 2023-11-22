within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record MineralFoam_TUDa =Buildings.HeatTransfer.Data.Solids.Generic (
    k=0.071,
    d=125,
    c=1000) "Mineral foam (k=0.071)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
