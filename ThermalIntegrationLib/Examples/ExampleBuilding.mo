within ThermalIntegrationLib.Examples;
model ExampleBuilding
  extends Modelica.Icons.Example;

  inner BaseClasses.SystemEnergyManager sem(useBuilding=true) annotation (Placement(transformation(extent={{60,60},{80,80}})));


  ProductionEquipment.GenericProcesses.MachineMultiDemand_simple machine_1 annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

  ProductionEquipment.GenericProcesses.MachineHeatDemand_simple machineHeatDemand_simple(ID=2) annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=31500000, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end ExampleBuilding;
