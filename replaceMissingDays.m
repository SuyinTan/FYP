%input time follow GMT 24 hour system


function replaceMissingDays(c_date_tracks, input_time)
index_to_be_deleted_arr=cell(1,200); %allocating by assuming it won't be more than 200 duplicate days

length_has_changed=1;

while length_has_changed
old_length=length(c_date_tracks);
count=1; %for duplicate array's indexing

for index=1:length(c_date_tracks)-1
   
    
    row_gap = floor(c_date_tracks{index+1,1})-floor(c_date_tracks{index,1});%normal gap in date should be a little more or less than 1. say 0.95<gap<1.05 (to allow for an 1.2hour late or early recording
    if (row_gap>1) %missing rows
       %c_date_tracks(index+row_gap:end+1,:)=c_date_tracks(index+1:end,:); %take the next row index+1:end and fit into the new index+rowgap
        for i=1:row_gap-1 %row gap is at least 2
            c_date_tracks(index+i+1:end+1,:)=c_date_tracks(index+i:end,:);
            c_date_tracks{index+i,1}=c_date_tracks{index,1}+i;
            c_date_tracks{index+i,2}=datestr(c_date_tracks{index+i,1},'dd/mm/yy');
            c_date_tracks{index+i,3}=NaN;
        end

    end
    %if you want to get rid of the days that have inaccurate times, and
    %make it NaN. 
%     if (time_gap~=1)
%    % if(time_gap>1.01 || time_gap<0.99) %0.01 is 15min 0.001 is 1min
%         fprintf('Wrong time at %d\n', index);
%             c_date_tracks{index,4}='Wrong time';
%     end
    
    if (row_gap<1)
        me_datenum=c_date_tracks{index,1};
        me_time=me_datenum-floor(me_datenum);
        
        u_datenum=c_date_tracks{index+1,1};
        u_time=u_datenum-floor(u_datenum);
        
        right_hour=input_time*1/24;
        
        if(abs(me_time-right_hour)<abs(u_time-right_hour))% if me_time is nearer to the right hour than you, delete you.
             fprintf('Duplicate row deleted at index %d\n', index+1);
             c_date_tracks{index+1,4}='Duplicate';
             index_to_be_deleted_arr{count}=index+1;
             count=count+1;

        else
            fprintf('Duplicate row deleted at index %d\n', index);
            c_date_tracks{index,4}='Duplicate';
            index_to_be_deleted_arr{count}=index;
            count=count+1;

        end
    
    end
    
end

new_length=length(c_date_tracks);

if old_length==new_length
    length_has_changed=0;
end

end



for j=1:count
   c_date_tracks(index_to_be_deleted_arr{j}-(j-1), :)=[];
end




 save('C:\Users\Suyin\Documents\Research papers\Experiment_011\complete_011_date_tracks.mat','c_date_tracks');
 load 'C:\Users\Suyin\Documents\Research papers\Experiment_011\complete_011_date_tracks.mat';