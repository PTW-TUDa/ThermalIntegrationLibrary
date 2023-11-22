within ThermalIntegrationLib.Internals;
model SemPowerPort
  SI.HeatFlowRate coolingPower=sum(coolingPowerPort[1:end].Power);
  SI.HeatFlowRate heatingPower=sum(heatingPowerPort[1:end].Power);
  SI.Power electricPower=sum(electricPowerPort[1:end].Power);

  ThermalIntegrationLib.Internals.ElectricPowerPort[5] electricPowerPort;
  ThermalIntegrationLib.Internals.HeatingPowerPort[5] heatingPowerPort;
  ThermalIntegrationLib.Internals.CoolingPowerPort[5] coolingPowerPort;
  ThermalIntegrationLib.Internals.DissipationPowerPort dissipationPowerPort;
  ThermalIntegrationLib.Internals.BuildingPort buildingPort;
equation
 // dissipationPowerPort.Power = coolingPower+heatingPower+electricPower;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end SemPowerPort;
