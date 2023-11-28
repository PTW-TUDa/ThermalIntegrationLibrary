within ThermalIntegrationLib.Examples;
model entire_factory_all_machines
  extends Modelica.Icons.Example;
  inner BaseClasses.SystemEnergyManager sem(useBuilding=true) annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ProductionEquipment.AnnealingOvens.AnnealingOven.AnnealingOven eiB_AnnealingOven_v1_1(ID=4) annotation (Placement(transformation(extent={{-20,-60},{40,0}})));
  ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal.EiB_CleaningMachine2Tanks_thermal eiB_CleaningMachine2Tanks_thermal(ID=3) annotation (Placement(transformation(extent={{-6,-6},{26,26}})));
  ProductionEquipment.MachineTools.TurningMachine.TurningMachine eiB_MachineTool(ID=2) annotation (Placement(transformation(extent={{-10,30},{30,70}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end entire_factory_all_machines;
