%str year can be two or four digits
%str month must be two digits
function days = days_of_month_in_str( str_month, str_year )
if strcmp(str_month,'02')
    if leapyear(str2double(str_year)) 
        days='29';
    else
        days='28';
    end

else
    if ismember(str_month,{'01','03','05','07','08','10','12'})
        days='31';
    else
    days='30';
    end
end