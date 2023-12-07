within ThermalIntegrationLib.BaseClasses.Internals;
model SemPowerPort
  extends Modelica.Icons.TypeReal;
  SI.HeatFlowRate coolingPower=sum(coolingPowerPort[1:end].Power);
  SI.HeatFlowRate heatingPower=sum(heatingPowerPort[1:end].Power);
  SI.Power electricPower=sum(electricPowerPort[1:end].Power);

  ThermalIntegrationLib.BaseClasses.Internals.ElectricPowerPort[5] electricPowerPort;
  ThermalIntegrationLib.BaseClasses.Internals.HeatingPowerPort[5] heatingPowerPort;
  ThermalIntegrationLib.BaseClasses.Internals.CoolingPowerPort[5] coolingPowerPort;
  ThermalIntegrationLib.BaseClasses.Internals.DissipationPowerPort dissipationPowerPort;
  ThermalIntegrationLib.BaseClasses.Internals.BuildingPort buildingPort;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end SemPowerPort;
