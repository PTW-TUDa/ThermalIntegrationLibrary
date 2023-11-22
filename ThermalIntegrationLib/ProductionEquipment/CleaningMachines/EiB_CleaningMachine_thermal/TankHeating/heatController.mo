within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TankHeating;
model heatController
  extends
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration.TechnicalConfiguration_a;
    parameter Integer st1, st2;
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput heating annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
public
  Modelica.Blocks.Interfaces.RealInput temp annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-110}), iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-110})));
initial equation
  pre(heating) = false;
equation
  if state < st1 or state > st2 then
    heating = temp <= T_lim or pre(heating) and temp < T_req; // state tank heating on/off
  else
    heating = false;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5), Text(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,0},
          textString="heating
controller")}),                                                  Diagram(coordinateSystem(preserveAspectRatio=false)));
end heatController;
