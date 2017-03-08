email_matlab_setup
addpath('matguts');

label = 'breq_test2';
name = 'Zachary Eilon'; % no punctuation, spaces are allowed;
stas = {'KIEV','HRV'};
nwks = 'IU';
chans = 'BHZ';
locs = '00';
datatype = 'SEED';
ofile = 'request_details';
odir = '.';

starttimes = {'11 Mar 2011 05:00:00'};
endtimes = {'11 Mar 2011 07:00:00'};

%% requesting the data
breq_fast_request(label,name,stas,chans,nwks,locs,starttimes,endtimes,datatype,ofile)

%% pausing to give the DMC processing time
fprintf('NOW IRIS 5 minutes to respond... check your email!\n')
fprintf('Once IRIS emails to say the data is ready, run the\nrest of the script.\n')
return

%% Downloading and processing the data
[ tr ] = breq_fast_process( label,name,stas,chans,nwks,locs,starttimes,true )

%% giving data time vectors
for itr = 1:length(tr)
    if isempty(tr(itr).network), continue; end
    tr(itr).tt = [0:tr(itr).sampleCount-1]'/tr(itr).sampleRate + tr(itr).startTime;
end

%% plotting
figure(1), hold on
for itr = 1:length(tr)
    if isempty(tr(itr).network), continue; end
    plot(tr(itr).tt,tr(itr).data);
end
