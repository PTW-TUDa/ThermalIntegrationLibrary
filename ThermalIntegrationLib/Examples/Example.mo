within ThermalIntegrationLib.Examples;
model Example
  inner BaseClasses.SystemEnergyManager sem(useBuilding=true)
                                            annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

  ProductionEquipment.MachineTools.MachineTool.TurningMachine turningMachine(
    redeclare ProductionEquipment.MachineTools.MachineTool.ProcessingProgramms.Kugelspiel_OP10 ProcessingProgramm_1,
    redeclare ProductionEquipment.MachineTools.MachineTool.ProcessingProgramms.Kugelspiel_OP20 ProcessingProgramm_2,
    redeclare ProductionEquipment.MachineTools.MachineTool.ProcessingProgramms.Steuerscheibe_OP10 ProcessingProgramm_3,
    redeclare ProductionEquipment.MachineTools.MachineTool.ProcessingProgramms.Steuerscheibe_OP20 ProcessingProgramm_4) annotation (Placement(transformation(extent={{-30,-48},{10,-8}})));
  FactoryBuilding.BuildingEnvelope.Test.BuildingEnvelope buildingEnvelope annotation (Placement(transformation(extent={{-20,0},{0,20}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=500, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Example;
