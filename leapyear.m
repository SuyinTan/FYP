function [ status ] = leapyear( year )
if mod(year, 4) == 0
    status = true;
    if mod(year, 100) == 0
        status=false;
        if mod(year,400)==0
            status = true;
        end
    end
else
    status=false;
end