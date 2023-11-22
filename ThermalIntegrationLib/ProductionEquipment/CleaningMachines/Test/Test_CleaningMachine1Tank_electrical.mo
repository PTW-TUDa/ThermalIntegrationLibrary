within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.Test;
model Test_CleaningMachine1Tank_electrical
  EiB_CleaningMachine1Tank_electrical.EiB_CleaningMachine1Tank_electrical eiB_CleaningMachine1Tank_electrical annotation (Placement(transformation(extent={{-4,-4},{24,24}})));
  inner ThermalIntegrationLib.BaseClasses.SystemEnergyManager sem annotation (Placement(transformation(extent={{80,80},{100,100}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end Test_CleaningMachine1Tank_electrical;
