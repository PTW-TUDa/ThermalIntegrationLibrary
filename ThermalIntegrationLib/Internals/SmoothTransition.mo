within ThermalIntegrationLib.Internals;
model SmoothTransition

  Real factor1_1(start=1.0);
  Real factor1_2(start=1.0);

  Real factor2_1(start=0.0);
  Real factor2_2(start=0.0);

  Boolean on_off(start=false);
  Real v(start=-1e10);
  Real u(start=-1e10);

  Real smooth1;
  Real smooth2;

  parameter Real transitionTime=1000;

 Modelica.Blocks.Interfaces.RealInput input1
   annotation (extent=[-140,40; -100,80], Placement(transformation(extent={{
            -140,40},{-100,80}}, rotation=0)));
 Modelica.Blocks.Interfaces.RealInput input2
   annotation (extent=[-140,-80; -100,-40], Placement(transformation(extent={{
            -140,-80},{-100,-40}}, rotation=0)));
 Modelica.Blocks.Interfaces.RealOutput smooth
   annotation (extent=[100,-10; 120,10], Placement(transformation(extent={{100,
            -10},{120,10}}, rotation=0)));
 Modelica.Blocks.Interfaces.BooleanInput flag
   annotation (extent=[-140,-20; -100,20], Placement(transformation(extent={{
            -140,-20},{-100,20}}, rotation=0)));

equation
  flag = on_off;

when flag then
  v=pre(time);
end when;

 when not flag then
   u = pre(time);
 end when;

 if flag then
   smooth1= factor1_1;
   smooth2 = factor2_1;
 else
   smooth1= factor1_2;
   smooth2= factor2_2;
 end if;

  factor1_1 = smoothTransition(
    time,
    v + transitionTime/2,
    transitionTime);
  factor1_2 = -smoothTransition(
    time,
    u + transitionTime/2,
    transitionTime) + 1;

  factor2_1 = -smoothTransition(
    time,
    v + transitionTime/2,
    transitionTime) + 1;
  factor2_2 = smoothTransition(
    time,
    u + transitionTime/2,
    transitionTime);

  smooth = input2*smooth1 + input1*smooth2;

 annotation (Diagram(graphics),
                      Icon(
      graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,54},{64,34}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
              "Smooth"),
        Text(
          extent={{-58,-4},{66,-24}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
              "Transition")},
     Rectangle(extent=[-100,100; 100,-100], style(
         color=0,
         rgbcolor={0,0,0},
         thickness=2,
         fillColor=7,
         rgbfillColor={255,255,255},
         fillPattern=1)),
     Text(
       extent=[-60,54; 64,34],
       style(
         color=0,
         rgbcolor={0,0,0},
         thickness=2,
         fillColor=7,
         rgbfillColor={255,255,255},
         fillPattern=1),
       string="Smooth"),
     Text(
       extent=[-58,-4; 66,-24],
       style(
         color=0,
         rgbcolor={0,0,0},
         thickness=2,
         fillColor=7,
         rgbfillColor={255,255,255},
         fillPattern=1),
       string="Transition")));
end SmoothTransition;

function smoothTransition
  input Real x;
  input Real transitionPoint=1;
  input Real transitionLength=1;
  input Integer funcNum=0 "Function selector";

  output Real weigthingFactor;
protected
  Real phi "Phase";
algorithm
  if (x < transitionPoint-0.5*transitionLength) then
    weigthingFactor := 1;
  elseif (x < transitionPoint+0.5*transitionLength) then
    phi := (x - transitionPoint)*Modelica.Constants.pi/transitionLength;
    if (funcNum == 0) then
      weigthingFactor := -1.0/2.0*sin(phi)+1.0/2.0;
    elseif (funcNum == 1) then
      weigthingFactor := -1.0/2.0*(2*cos(phi)*sin(phi) + 2*phi - Modelica.Constants.pi)/
        Modelica.Constants.pi;
    elseif (funcNum == 2) then
      weigthingFactor := 1.0/6.0*(-4.0*sin(phi)*cos(phi)^3 - 6.0*phi - 3.0*sin(2.0*phi) +
        3.0*Modelica.Constants.pi)/Modelica.Constants.pi;
    elseif (funcNum == 3) then
      weigthingFactor := 1.0/30.0*(-16*cos(phi)^5*sin(phi) - 20*cos(phi)^3*sin(phi) - 30*cos(
        phi)*sin(phi) - 30*phi + 15*Modelica.Constants.pi)/Modelica.Constants.pi;
    else
      weigthingFactor := 0;
    end if;
  else
    weigthingFactor := 0;
  end if;

  annotation ( Documentation(info="<html>
<p><br>This function smoothly changes its output from 1 to 0 around the <code>TransitionPoint</code> with the <code>TransitionLength</code>.</p>
<p><br>The parameter <code>funcNum</code> defines the smoothness of the transition.</p>
<p>With funcNum=0, the transition is continuous. With funcNum=1 the transition is once continuously differentiable. With funcNum=2, the transition is twice continuously differentiable.</p>
</html>"));
end smoothTransition;
