within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.MechanicalProcesses;
model ah
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
equation

  if state == 13 or state == 14 then
    P_el = 3;
  else
    P_el = 0;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{16,40},{-24,0},{16,-40},{-26,-94},{26,-40},{-14,0},{16,40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{62,40},{22,0},{62,-40},{20,-94},{72,-40},{32,0},{62,40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-30,40},{-70,0},{-30,-40},{-72,-94},{-20,-40},{-60,0},{-30,40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Text(
          extent={{-80,100},{80,40}},
          lineColor={0,0,0},
          textString="air heater")}),
                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
end ah;
