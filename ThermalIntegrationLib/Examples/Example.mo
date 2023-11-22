within ThermalIntegrationLib.Examples;
model Example
  extends Modelica.Icons.Example;

  inner BaseClasses.SystemEnergyManager sem annotation (Placement(transformation(extent={{60,60},{80,80}})));

  ProductionEquipment.GenericProcesses.MachineMultiDemand_simple machine_1 annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=500, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Example;
