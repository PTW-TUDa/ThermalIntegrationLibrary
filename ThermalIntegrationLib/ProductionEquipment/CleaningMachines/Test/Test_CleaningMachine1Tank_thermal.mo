within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.Test;
model Test_CleaningMachine1Tank_thermal
  inner ThermalIntegrationLib.BaseClasses.SystemEnergyManager sem annotation (Placement(transformation(extent={{70,70},{90,90}})));
  EiB_CleaningMachine1Tank_thermal.EiB_CleaningMachine1Tank_thermal eiB_CleaningMachine1Tank_thermal annotation (Placement(transformation(extent={{-16,-16},{16,16}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end Test_CleaningMachine1Tank_thermal;
