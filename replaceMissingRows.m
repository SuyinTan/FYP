%this function serves to replace missing days of recording and identify
%duplicate days
%can be used to identify the difeerence
%future update: replace missing rows before and after start and end dates.
%eg. start_date=24/7/2011. replace from 1/7/2011. end
%date=17/12/2013....replace until 31.12.2013

function xc_date_tracks=replaceMissingRows(xc_date_tracks, input_time)
   
index_to_be_deleted_arr=cell(1,200); %allocating by assuming it won't be more than 200 duplicate days

length_has_changed=1;

while length_has_changed
old_length=length(xc_date_tracks);
count=1; %for duplicate array's indexing

for index=1:length(xc_date_tracks)-1
   
    
    row_gap = floor(xc_date_tracks{index+1,1})-floor(xc_date_tracks{index,1});%normal gap in date should be a little more or less than 1. say 0.95<gap<1.05 (to allow for an 1.2hour late or early recording
    if (row_gap>1) %missing rows
       %c_date_tracks(index+row_gap:end+1,:)=c_date_tracks(index+1:end,:); %take the next row index+1:end and fit into the new index+rowgap
        for i=1:row_gap-1 %row gap is at least 2
            xc_date_tracks(index+i+1:end+1,:)=xc_date_tracks(index+i:end,:);
            xc_date_tracks{index+i,1}=xc_date_tracks{index,1}+i;
            xc_date_tracks{index+i,2}=datestr(xc_date_tracks{index+i,1},'dd/mm/yy');
            xc_date_tracks{index+i,3}=NaN;
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
        me_datenum=xc_date_tracks{index,1};
        me_time=me_datenum-floor(me_datenum);
        
        u_datenum=xc_date_tracks{index+1,1};
        u_time=u_datenum-floor(u_datenum);
        
        right_hour=input_time*1/24;
        
        if(abs(me_time-right_hour)<abs(u_time-right_hour))% if me_time is nearer to the right hour than you, delete you.
             fprintf('Duplicate row deleted at index %d\n', index+1);
             xc_date_tracks{index+1,4}='Duplicate';
             index_to_be_deleted_arr{count}=index+1;
             count=count+1;

        else
            fprintf('Duplicate row deleted at index %d\n', index);
            xc_date_tracks{index,4}='Duplicate';
            index_to_be_deleted_arr{count}=index;
            count=count+1;

        end
    
    end
    
end

new_length=length(xc_date_tracks);

if old_length==new_length
    length_has_changed=0;
end

end

for j=1:count
   xc_date_tracks(index_to_be_deleted_arr{j}-(j-1), :)=[];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Replace first and last month days

 first_datenum=floor(xc_date_tracks{1,1});
 last_datenum=floor(xc_date_tracks{length(xc_date_tracks),1});
 last_datestr=datestr(datenum(last_datenum),'dd/mm/yy');
 first_datestr=datestr(datenum(first_datenum),'dd/mm/yy');
  
 str_last_year =  last_datestr(7:8);
 str_last_month =  last_datestr(4:5);  % just need to know the month and year of the last month, to know the days it has 31 or 30
 str_first_year =  first_datestr(7:8);
 str_first_month =  first_datestr(4:5);
 
 total_days_of_month=days_of_month_in_str(str_last_month, str_last_year);

 
true_end_datenum=datenum([total_days_of_month,'/',str_last_month,'/',str_last_year], 'dd/mm/yy');
 true_start_datenum=datenum(['01/',str_first_month,'/',str_first_year], 'dd/mm/yy');
 period_datenum=true_end_datenum-true_start_datenum+1; %is also the true number of rows. 

 missing_rows_before_first_date=first_datenum-true_start_datenum;
  missing_rows_after_last_date=true_end_datenum-last_datenum;
  

for i=1:missing_rows_before_first_date
    xc_date_tracks(i+1:end+1,:)=xc_date_tracks(i:end,:);
    xc_date_tracks{i,1}=true_start_datenum+i-1;
    xc_date_tracks{i,2}=datestr(true_start_datenum+i-1,'dd/mm/yy');
    xc_date_tracks{i,3}=NaN;
    
end

false_end_index=length(xc_date_tracks);
j=1;
last_datenum=floor(xc_date_tracks{false_end_index,1});
for i=false_end_index+1:false_end_index+missing_rows_after_last_date
    xc_date_tracks{i,1}=last_datenum+j;
    xc_date_tracks{i,2}=datestr(last_datenum+j,'dd/mm/yy');
    xc_date_tracks{i,3}=NaN;
    j=j+1;
    
end

%check if true_end_datenum = real end index punya datenum
real_end_index=length(xc_date_tracks);
if true_end_datenum == floor(xc_date_tracks{real_end_index,1})
    fprintf('End date num is correct');
else
    fprintf('End date num is NOT correct');
end

%check if the number of rows are correct according to the period.
if length(xc_date_tracks)== period_datenum
    fprintf('No missing nor extra days');
else
    fprintf('There are missing or extra days');
end

 save('C:\Users\Suyin\Documents\Research papers\Experiment_011\extracomplete_011_date_tracks.mat','xc_date_tracks');
 %load ('C:\Users\Suyin\Documents\Research papers\Experiment_011\extracomplete_011_date_tracks.mat')
 
 
    
     