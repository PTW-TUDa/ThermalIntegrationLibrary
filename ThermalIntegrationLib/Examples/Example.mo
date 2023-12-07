within ThermalIntegrationLib.Examples;
model Example
  inner BaseClasses.SystemEnergyManager sem(useBuilding=true)
                                            annotation (Placement(transformation(extent={{80,80},{100,100}})));

  ProductionEquipment.MachineTools.TurningMachine.TurningMachine turningMachine(ID=2,
    redeclare ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.Kugelspiel_OP10 ProcessingProgramm_1)    annotation (Placement(transformation(extent={{-30,-50},{10,-10}})));
  FactoryBuilding.BuildingElements.FactoryBuilding factoryBuilding(ID=1) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=500, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Example;
