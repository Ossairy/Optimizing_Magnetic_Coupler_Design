function [Tqo] = TorqueCalculate(MCPvec)


      Kdash=(10)^2;

      S= MCPvec(1,1);
      Ag=MCPvec(1,2);
      D=MCPvec(1,3)*10;
      n=MCPvec(1,4);

           
    p=(3.14159*D)/n;

    d1=sqrt(S^2+Ag^2);

    d2=(sqrt((p-S)^2+Ag^2));

    F1dash=Kdash/(d1^2);
    F2dash=Kdash/(d2^2);
    R=D/2;

    F1=F1dash*(S/d1);
    F2=F2dash*((p-S)/d2);
    Tqo=n*(F1+F2)*R/100;



end