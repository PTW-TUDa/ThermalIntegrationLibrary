within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal.TankHeating;
model heatController
  parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
  parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid";
  parameter Integer washingTable[:,1] "States when washing is active";
  Integer rows = size(washingTable,1);
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
  if state < washingTable[1,1] or state > washingTable[rows,1] then
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
