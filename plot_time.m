function plot_time(c_date_tracks, handle)
MONTHS={'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'};
year_arr={'10','11','12','13','14'};
color_arr={'k','r','b','g','p'};
month_num={'01','02','03','04','05','06','07','08','09','10','11','12'};
start_index=1;

for num=1:12
    the_month=MONTHS{num};  %CHANGE
    the_month_num=month_num{num};
    
    if num~=2
        last_date=days_of_month_in_str(the_month_num,'0');
    end
    
    h=figure('Name', [the_month,' Months']);%CHANGE
    hold (handle,'off');
    hold (handle,'on');
    
    xlabel('Day of Month');
    ylabel('No. of Tracks');
    title(['Graph of No. of Daily Tracks in ', the_month]);
    count=1;%for save_legend array
    i=1; %the year count
    
    clear save_legend;
    save_legend=cell(1,1);
    
    for index=1:length(c_date_tracks)
        str_date=datestr( floor(c_date_tracks{index,1}),'dd/mm/yy');
        str_year = str_date(7:8);
        if num==2
            last_date=days_of_month_in_str(the_month_num, str_year);
        end
        
        if str2double(str_year)>str2double(year_arr{i})
            i=i+1;
        end
        
        if (strcmp(str_date, ['01/',the_month_num,'/',year_arr{i}])) %CHANGE
            start_index=index;
        end
        
        if(strcmp(str_date, [last_date,'/',the_month_num,'/',year_arr{i}]))  %CHANGE
            end_index=index;
            if (strcmp(datestr( floor(c_date_tracks{start_index,1}),'dd/mm/yy'),['01/',the_month_num,'/',year_arr{i}]))
                plot(handle, cell2mat(c_date_tracks(start_index:end_index,3:3)),color_arr{i}, 'LineWidth',2);
                
                save_legend{count}=[the_month,' 20',year_arr{i}];
                count=count+1;
            end
            if(i<length(year_arr))
                i=i+1;
            end
        end
        
        
    end
    % for k=1:length(save_legend)
    %     if isempty(save_legend{k})
    
    legend(save_legend);
    %legend([the_month, ' 2010'],[the_month, ' 2011'],[the_month, ' 2012'],[the_month, ' 2013'],[the_month, ' 2014'] );
    saveas(h,[the_month,'_months'],'fig')
    saveas(h,[the_month,'_months'],'png')
    hold(handle,'off');
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Plot the weeks
% %Done ad hoc manually.
%
% figure('Name', 'Weekly View') %CHANGE
% hold on
% xlabel('Week in Year');
% ylabel('No. of Tracks');
% title('Graph of No. of Weekly Tracks throughout the Year');
%
%
% plot(cell2mat(c_week_tracks(1:23,1)),cell2mat(c_week_tracks(1:23,4)), 'k', 'LineWidth',2);
% plot(cell2mat(c_week_tracks(24:75,4)),'r', 'LineWidth',2);
% plot(cell2mat(c_week_tracks(76:127,4)),'b', 'LineWidth',2);
% plot(cell2mat(c_week_tracks(128:179,4)),'g', 'LineWidth',2);
% plot(cell2mat(c_week_tracks(180:204,4)),'m', 'LineWidth',2);
% legend('2010','2011','2012','2013','2014');


