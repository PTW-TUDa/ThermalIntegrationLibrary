within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.MechanicalProcesses;
model scc
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
equation

  if state <= 14 and state >=12 then
    P_el = 5.5;
  else
    P_el = 0;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{-70,50},{70,-90}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{68,-2},{-54,24}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{68,-38},{-54,-64}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-60,100},{60,60}},
          lineColor={0,0,0},
          textString="scc")}),   Diagram(coordinateSystem(preserveAspectRatio=false)));
end scc;
