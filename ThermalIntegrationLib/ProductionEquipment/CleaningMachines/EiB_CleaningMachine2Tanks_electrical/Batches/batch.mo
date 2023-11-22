within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.Batches;
model batch
  parameter Modelica.SIunits.Mass m_batch "Mass of batch";
  parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch";
  parameter Modelica.SIunits.Mass m_rack "Mass of batching rack";
  parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack";
  Real T_batch,
        Q_dot_batch(start=0);
  Modelica.Blocks.Interfaces.BooleanInput t1_state annotation (Placement(transformation(extent={{-160,110},{-140,130}}),
                                   iconTransformation(extent={{-160,110},{-140,130}})));
  Modelica.Blocks.Interfaces.RealInput T_t1 annotation (Placement(transformation(extent={{-160,70},{-140,90}}),
                         iconTransformation(extent={{-160,70},{-140,90}})));
  Modelica.Blocks.Interfaces.RealInput tank_time annotation (Placement(transformation(extent={{-160,30},{-140,50}}),
                             iconTransformation(extent={{-160,30},{-140,50}})));
  Modelica.Blocks.Interfaces.BooleanInput new_batch annotation (Placement(transformation(extent={{-160,-10},{-140,10}}),
                                   iconTransformation(extent={{-160,-10},{-140,10}})));
  Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(transformation(extent={{-160,-50},{-140,-30}}),
                          iconTransformation(extent={{-160,-50},{-140,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput t2_state annotation (Placement(transformation(extent={{-160,-90},{-140,-70}}),
                                    iconTransformation(extent={{-160,-90},{-140,-70}})));
  Modelica.Blocks.Interfaces.RealInput T_t2 annotation (Placement(transformation(extent={{-160,-130},{-140,-110}}),
                          iconTransformation(extent={{-160,-130},{-140,-110}})));
  Modelica.Blocks.Interfaces.RealOutput q_dot_batch
    annotation (Placement(transformation(extent={{140,60},{160,80}})));
  Modelica.Blocks.Interfaces.RealOutput t_batch
    annotation (Placement(transformation(extent={{140,-80},{160,-60}})));
initial equation
  T_batch = T_amb;
equation

  if t1_state then // cleaning in progress, heat extraction by batch and rack
    Q_dot_batch = (m_batch*c_batch+m_rack*c_rack)*(T_t1-T_batch)/tank_time;
  elseif t2_state then
    Q_dot_batch = (m_batch*c_batch+m_rack*c_rack)*(T_t2-T_batch)/tank_time;
  else // cleaning NOT in progress
    Q_dot_batch = 0;
  end if;

  der(T_batch) = Q_dot_batch/(m_batch*c_batch+m_rack*c_rack); // batch+rack temperature slope

  t_batch = T_batch;
  q_dot_batch = Q_dot_batch;

  when edge(new_batch) then
    reinit(T_batch, T_amb);
  end when;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}}),
                                                                graphics={
        Rectangle(
          extent={{-140,140},{140,-140}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None),
        Polygon(
          points={{0,80},{-120,28},{0,-20},{120,28},{0,80}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-60,4},{-120,-22},{0,-70},{120,-22},{60,4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,-46},{-120,-72},{0,-120},{120,-72},{60,-46}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-100,140},{100,80}},
          lineColor={0,0,0},
          textString="batch")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}})));
end batch;
