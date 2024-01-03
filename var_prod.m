% Variable cosmogenic production (clean)

% needs CRONUScalc (Marrero) and Balco's muon codes somewhere in $PATH to access functions 

% Coordinates Madison, WI
% Extends a little higher than the initial surface so we can accomodate

% This can take a while to run... grab some tea

elevations=linspace(0, 250, (250-0)*4);

lat = 43.0706;
long = -89.40626;

% Allocate
scale_lsd=zeros(1,length(elevations));
scale_stone=zeros(1,length(elevations));
Ps_lsd=zeros(1,length(elevations));
Ps_stone=zeros(1,length(elevations));

% SLHL for spallation (Ps)
Ps_SLHL = 3.92;   % 3.92; % 10Be Borchers et al., 2016 LSD/Sa -- 28.54 26Al -- 12.76 14C

Rc=lat_to_Rc(lat); % cutoff ridigity at 44.18 degrees N (GV)
SPhi=587.4; % solar modulation of muon flux (current day) (MV)

density=2.65; % g cm-3 - rock density
z=10; % in meters
z_cm = linspace(0,(z*100),(z*100)); % 1 cm increments
z_gcm2 = z_cm*density;


for n=1:length(elevations)
   out = scalingcalc(lat, long, elevations(n));
   scale_lsd(n) = out.SaSel10; % 
   scale_stone(n) = out.StSel10; %
end

Ps_lsd = Ps_SLHL*scale_lsd;
Ps_stone = Ps_SLHL*scale_stone;

L1_lsd=zeros(size(elevations));

for n=1:length(elevations)
    h_temp=ERA40atm(lat, long, elevations(n));
    att_temp=attenuationlength(lat,long,elevations(n), h_temp);
    L1_lsd(n)=att_temp;
end


pressures=zeros(size(elevations));
for n=1:length(elevations)
    pressures(n)=ERA40atm(lat, long, elevations(n));
end



P_neg_LSD_el=zeros([length(elevations),length(z_gcm2)]);
P_fast_LSD_el=zeros([length(elevations),length(z_gcm2)]);


for n=1:length(elevations)
    for m=1:length(z_gcm2)
        
        temp_muon=P_mu_totalLSD(z_gcm2(m), pressures(n), Rc, SPhi, consts, 'yes');
        P_fast_LSD_el(n,m)=temp_muon.P_fast;
        P_neg_LSD_el(n,m)=temp_muon.P_neg;
    end
end

fit_LSD_neg=cell(1,length(elevations));
gof_LSD_neg=cell(1,length(elevations));

fit_LSD_fast=cell(1,length(elevations));
gof_LSD_fast=cell(1,length(elevations));

for n=1:length(elevations)
    [fit_LSD_neg{n}, gof_LSD_neg{n}]=fit(z_gcm2', P_neg_LSD_el(n,:)', 'exp1');
end

for n=1:length(elevations)
    [fit_LSD_fast{n}, gof_LSD_fast{n}]=fit(z_gcm2', P_fast_LSD_el(n,:)', 'exp1');
end

P_neg_LSD_el_a = zeros(size(elevations));
P_neg_LSD_el_b = zeros(size(elevations));

P_fast_LSD_el_a = zeros(size(elevations));
P_fast_LSD_el_b = zeros(size(elevations));


for n=1:length(elevations)
    P_neg_LSD_el_a(n)=fit_LSD_neg{n}.a;
    P_neg_LSD_el_b(n)=fit_LSD_neg{n}.b;
    
    P_fast_LSD_el_a(n)=fit_LSD_fast{n}.a;
    P_fast_LSD_el_b(n)=fit_LSD_fast{n}.b;
    
end


% Partial-cubic Hermite interpolant for near-surface negative muon capture rates and
% psedo-attentuation lengths with respect to elevation -- I didn't use these in the end; the variations were meaningless, so a mean() is taken.
P_neg_pchip=pchip(elevations,P_neg_LSD_el_a);

L2_pchip=pchip(elevations,P_neg_LSD_el_b);

% Same thing with production from fast muons
P_fast_pchip=pchip(elevations,P_fast_LSD_el_a);

L4_pchip=pchip(elevations,P_fast_LSD_el_b);

% Spallogenic production
P_spal_pchip=pchip(elevations,Ps_lsd);

L1_pchip=pchip(elevations, L1_lsd);

% Evaluate interpolants at each grid point at each iteration

L2=mean(ppval(L2_pchip,elevations));

L4=mean(ppval(L4_pchip,elevations));

L1=mean(ppval(L1_pchip,elevations));

