within ThermalIntegrationLib.Examples.Records;
record ETA_TechnicalConfiguration_TurningMachine
  extends Modelica.Icons.Record;
  extends ThermalIntegrationLib.ProductionEquipment.MachineTools.MachineTool.Records.TechnicalConfiguration_base(
    T_target_ControlCabinet=293.15,
    T_target_MachineTool=293.15,
    T_target_coolWater=303.15,
    T_target_coldWater=293.15,
    WaterCooledCompressionChiller=true,
    CentralColdWater=false,
    ContControl=true,
    lambda_components=2000,
    CorrectionFactor=0.5,
    lambda_loss=553.99,
    lambda_coolinglubricant=89,
    lambda_machinecooling=38.14,
    C_MachineTool=549819.89,
    lambda_decentral=127.12);
    //DecentralCoolingLubricantCooling=false,"
    //WaterCooledControlCabinet=false,"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ETA_TechnicalConfiguration_TurningMachine;
