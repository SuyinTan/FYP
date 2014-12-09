
%To extract the number of tracks/per day in all days of a camera scene
%Change camera_file to the location of the desired camera's tracks.txt folder.
function date_tracks=tracks_data_array(camera_file)
%camera_file='G:\Camera\011\011_tracks';

 camera_folder= dir(camera_file);
 length(camera_folder);
 count=0;
 date_tracks={date, count};

 index=1;
 for k=3:length(camera_folder)
     %camera_folder(k).name
     count=0;
     [tr, tfr, tx1, ty1] = textread([camera_file,'\',camera_folder(k).name ], '%d %d %d %d',-1);
     for j=1:size(tr)-1
         if tr(j+1)-tr(j)~=0
             count=count+1;
         end


     end
     %001_2010-11-25_11-00-00_tracks
     s=camera_folder(k).name;
     year=str2double(s(5:8));
     month=str2double(s(10:11));
     day=str2double(s(13:14));
     hour=str2double(s(16:17));
     min=str2double(s(19:20));
     sec=str2double(s(22:23));
     dateNum=datenum(year,month,day, hour, min, sec);

     date_tracks{index,1}=dateNum;
     date_tracks{index,2}=datestr(dateNum);
     date_tracks{index,3}=count;
    
     index=index+1; %new day, new row index


 end
 %save('C:\Users\Suyin\Documents\Research papers\Experiment_011\011_date_tracks.mat','date_tracks');
 save('C:\Users\Suyin\Documents\Research papers\Experiment_011\011_gui_date_tracks.mat','date_tracks'); %when free, correct name


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % get weeks table ----Weekno. start datenum.  startDate. Weekly tracks no.
% % Week 30	July 26, 2010 to	August 1, 2010
% 
% index=2;
% week_no=30;
% %c_week_tracks={week_no, start_datenum,  start_date, weekly_track_no};
% index2=1;
% while (index<1426)
%     start_datenum= c_date_tracks{index,1};
%     start_date=c_date_tracks{index,2};
%     weekly_tracks= 0;
%     
%     for i=1:7
%         if(isnan(c_date_tracks{index,3}))
%             daily_tracks=0;
%         else
%             daily_tracks=c_date_tracks{index,3};
%         end
%         weekly_tracks= weekly_tracks + daily_tracks;
%         index=index+1;
%     end
%     
%     c_week_tracks{index2,1}=week_no;
%     c_week_tracks{index2,2}=start_datenum;
%     c_week_tracks{index2,3}=start_date;
%     c_week_tracks{index2,4}=weekly_tracks;
%     
%     %new week
%     if(week_no<52)
%         week_no=week_no+1;
%     else
%         week_no=1;
%     end
%     %new row
%     index2=index2+1;
%     
% end
% 
% save('C:\Users\Tan Chun Hau\Documents\Research papers\Experiment\c_week_tracks.mat','c_week_tracks');