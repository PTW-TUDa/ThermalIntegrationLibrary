within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record FoamGlassGranulate=Buildings.HeatTransfer.Data.Solids.Generic (
    k=0.12,
    d=150,
    c=900) "Foam glass granulate (k=0.12)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
