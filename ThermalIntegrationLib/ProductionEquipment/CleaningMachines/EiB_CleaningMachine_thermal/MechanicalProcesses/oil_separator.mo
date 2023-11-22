within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.MechanicalProcesses;
model oil_separator
  Modelica.Blocks.Interfaces.RealOutput P_el annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput dur_t1 annotation (Placement(transformation(extent={{-120,-60},{-100,-40}}),
                   iconTransformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-120,40},{-100,60}}),   iconTransformation(extent={{-120,40},{-100,60}})));
protected
  Modelica.SIunits.Time timer;
initial equation
  pre(timer) = 0;
equation
  when state >= 5 and state <= 7 then
    timer = time + dur_t1/2;
  end when;
  if state >= 5 and state <= 7 and timer >= time then // oil separator active
    P_el = 0.2;
  else // other processes
    P_el = 0;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-80,100},{80,0}},
          lineColor={0,0,0},
          textString="oil sep"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-80,-38},{-40,-8},{0,-34},{40,-62},{80,-42}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-80,-38},{-40,-18},{0,-44},{40,-72},{80,-42}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier)}),                               Diagram(coordinateSystem(preserveAspectRatio=false)));
end oil_separator;
