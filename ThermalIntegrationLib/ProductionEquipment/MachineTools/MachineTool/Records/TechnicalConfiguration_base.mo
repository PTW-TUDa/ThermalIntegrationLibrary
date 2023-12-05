within ThermalIntegrationLib.ProductionEquipment.MachineTools.MachineTool.Records;
record TechnicalConfiguration_base
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.HeatCapacity C_MachineTool "Heat capacity of machine tool" annotation(Dialog(tab = "Thermal system properties"));
  parameter Modelica.SIunits.ThermalConductance lambda_coolinglubricant "Thermal conductance for coolinglubricant system" annotation(Dialog(tab = "Thermal system properties"));
  parameter Modelica.SIunits.ThermalConductance lambda_machinecooling "Thermal conductance for machine cooling system"
                                                                                                                      annotation(Dialog(tab = "Thermal system properties"));
  parameter Modelica.SIunits.ThermalConductance lambda_loss "Thermal conductance for losses" annotation(Dialog(tab = "Thermal system properties"));
  parameter Modelica.SIunits.ThermalConductance lambda_components "Abstract physical quantity to describe thermal behavior of components" annotation(Dialog(tab = "Thermal system properties"));
  parameter Modelica.SIunits.ThermalConductance lambda_decentral "Abstract physical quantity to describe thermal behavior of components" annotation(Dialog(tab = "Thermal system properties"));

  parameter Boolean CentralColdWater "If true then cold water is supplied centrally. If false then cold water is supplied decentrally" annotation(Dialog(tab = "Technical configuration", group = "Configuration"));
  //parameter Boolean WaterCooledControlCabinet "If true then water cooled control cabinet. If false then air cooled control cabinet" annotation(Dialog(tab = "Technical configuration", group = "Configuration"));
  parameter Boolean WaterCooledCompressionChiller "If true then water cooled compression chiller. If false then air cooled compression chiller" annotation(Dialog(tab = "Technical configuration", group = "Configuration"));
  parameter Boolean ContControl "If true then continuous control. If false then hysteresis control" annotation(Dialog(tab = "Technical configuration", group = "Configuration"));
  //parameter Boolean DecentralCoolingLubricantCooling "If true then cooling lubricant is cooled via compression chiller else via central cold water"annotation(Dialog(tab = "Technical configuration", group = "Configuration"));
  parameter Real CorrectionFactor "Correction factor of compression chiller" annotation(Dialog(tab = "Technical configuration", group = "Components"));

  parameter Modelica.SIunits.ThermodynamicTemperature T_target_coldWater "Target temperature of cold water system" annotation(Dialog(tab = "Temperatures", group = "Target-temperatures"));
  parameter Modelica.SIunits.ThermodynamicTemperature T_target_coolWater "Target temperature of cool water system" annotation(Dialog(tab = "Temperatures", group = "Target-temperatures"));
  parameter Modelica.SIunits.ThermodynamicTemperature T_target_MachineTool "Target temperature of machine tool" annotation(Dialog(tab = "Temperatures", group = "Target-temperatures"));
  parameter Modelica.SIunits.ThermodynamicTemperature T_target_ControlCabinet "Target temperature of machine tool" annotation(Dialog(tab = "Temperatures", group = "Target-temperatures"));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end TechnicalConfiguration_base;
