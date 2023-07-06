function [Tout] = PSO()




%% That Code needs Three functions to run :  TorqueCalculate() , CheckFeasibility() and FindBest()
%% we used that technique in order to use that functions in any other optimization code since they are generally used.



population = 1000;
iterations=100;

w=0.7;
c1=1.49;
c2=c1;
Nbest=0;





GenVec =zeros(population,5);  %%  Create new vector holding PSO parameters and the four decision variable are S, Ag ,D and n.  %%
%%% The gen Vector Column is ( S-Slip-    Ag-Air_Gap-    D-Desk_Diameter-
%%% n-Number_of_magnets- ) && personal.
%%% [ S Ag D n PB]
TqVec =zeros(1,population);   %%  Creating vector holds the torques of every patrticpant of the population.
VelVec =zeros(population,4);


%%%Generating first initial parameters -Feasible ones with its own constrains-%%%%


%%                                   %% Generate the initial Gens %%                                        %%
i=1;
while(i<=population)
    GenVec(i,2)=(25-5).*rand(1,1)+5;
    GenVec(i,3)=(40-10).*rand(1,1)+10;
    nmax=(1.5*GenVec(i,3))/2;
    GenVec(i,4)=(int16((nmax-2).*rand(1,1)+2))*2;  %% multiplyed by 2 to be always even number
    p=(3.14159*GenVec(i,3))/GenVec(i,4);
    GenVec(i,1)=(p-1).*rand(1,1)+1;
i=i+1;
end

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                    %% END Initial Condition %%    

while(iterations>0)

i=1;
while(i<=population)
    j=1;
    while(j<=4)
        %%GenVec(i,j)=1;

        %%Generate to random values for r1 & r2 not equal to each other
          Rn=zeros(1,2);
          r=1;
         while(r<=2)
            Rn(1,r)=randi(4,1);
             if(Rn(1,1)==Rn(1,2))
            Rn(1,r)=randi(4,1);
             else
               r=r+1;
             end
       
          end

        %%Calculate new velocity and Gaurantee it feasibility using
        %%checkFeasibility method.
            f=0;



        
            V= w*VelVec(i,j)+c1*Rn(1,1)*(GenVec(i,5)-GenVec(i,j))+c2*Rn(1,2)*(Nbest-GenVec(i,j));
            P= GenVec(i,j)+V;
            f=CheckFeasibility(GenVec(i,1:4),P,j);

            %%if the solution is feasibile then update the position and velocity if not
            %%update only the velocity

            if(f==1)
                GenVec(i,j)=P;
            end

            VelVec(i,j)=V;

            %%update the personal Best and Global best 
            %%update with Asynchronous technique

            T=TorqueCalculate(GenVec(i,1:4));

            if(T>GenVec(i,5))
                GenVec(i,5)=T;
            end

            if(T>Nbest)
                Nbest=T;
            end
        
        j=j+1;


    end
TqVec(1,i)=T;    %%Record the torque value in the torque vector



    i=i+1;
end


iterations=iterations-1;
end
%%%Find the best torque value and its decision variables

ChVec =FindBest(TqVec,population);
%%%ChVec saves the addresses of the population in assending order with
%%%respect to their torque value.



display(GenVec((ChVec(1,1)),1:4));
Tout=TqVec(1,ChVec(1,1));



%%%increasing population gives the system the chance to explore more and
%%%findes better solution on the other hand increasing the iterations
%%%causes the system to got trapped in local minima.

end