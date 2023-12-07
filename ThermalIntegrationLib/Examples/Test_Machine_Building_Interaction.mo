within ThermalIntegrationLib.Examples;
model Test_Machine_Building_Interaction
  extends Modelica.Icons.Example;
  inner BaseClasses.SystemEnergyManager sem(useBuilding=true)
                                            annotation (Placement(transformation(extent={{80,80},{100,100}})));

  ProductionEquipment.MachineTools.TurningMachine.TurningMachine turningMachine(ID=2,
    redeclare ThermalIntegrationLib.Examples.Records.ETA_TechnicalConfiguration_TurningMachine TechnicalConfiguration,
    redeclare ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.Kugelspiel_OP10 ProcessingProgramm_1)    annotation (Placement(transformation(extent={{-30,-50},{10,-10}})));
  FactoryBuilding.ProductionHall.Test.Test_BuildingEnvelope test_BuildingEnvelope annotation (Placement(transformation(extent={{-20,0},{0,20}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=31536000, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Test_Machine_Building_Interaction;
