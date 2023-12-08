within ThermalIntegrationLibrary.Examples;
model Test_MachineBuildingInteraction
  extends Modelica.Icons.Example;
  inner BaseClasses.SystemEnergyManager sem(useBuilding=true)
                                            annotation (Placement(transformation(extent={{80,80},{100,100}})));

  ProductionEquipment.MachineTools.TurningMachine.TurningMachine turningMachine(
    ID=3,
    redeclare ThermalIntegrationLibrary.Examples.Records.ETA_TechnicalConfiguration_TurningMachine
                                                                                               TechnicalConfiguration,
    redeclare ProductionEquipment.MachineTools.TurningMachine.ProcessingProgramms.Kugelspiel_OP10 ProcessingProgramm_1)    annotation (Placement(transformation(extent={{-20,-10},{20,30}})));
  FactoryBuilding.ProductionHall.Test.Test_BuildingEnvelope test_BuildingEnvelope annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  ProductionEquipment.CleaningMachines.CabinetCleaningMachine.CabinetCleaningMachine cabinetCleaningMachine(ID=2, redeclare ThermalIntegrationLibrary.Examples.Records.ETA_TechnicalConfiguration_CabinetCleaningMachine
                                                                                                                                                                                                        TechnicalConfiguration) annotation (Placement(transformation(extent={{-56,-6},{-24,26}})));
  ProductionEquipment.Ovens.AnnealingOven.AnnealingOven annealingOven(ID=4, redeclare ThermalIntegrationLibrary.Examples.Records.ETA_TechnicalConfiguration_AnnealingOven
                                                                                                                                                                      TechnicalConfiguration) annotation (Placement(transformation(extent={{10,-20},{70,40}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=31536000, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Test_MachineBuildingInteraction;
