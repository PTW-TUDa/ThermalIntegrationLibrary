within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record RigidPURFoam_025 = Buildings.HeatTransfer.Data.Solids.Generic (
    k=0.025,
    d=32,
    c=1300) "RigidPURFoam (k=0.025)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
