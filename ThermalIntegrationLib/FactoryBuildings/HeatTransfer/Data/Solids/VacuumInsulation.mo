within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record VacuumInsulation =Buildings.HeatTransfer.Data.Solids.Generic (
    k=0.007,
    d=195,
    c=900) "Vacuum insulation (k=0.007)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
