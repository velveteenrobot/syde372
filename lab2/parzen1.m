function [x, dist] = parzen1(data, std_dev, step)

    N = length(data);
    x = [min(data):step:max(data)];

    window = [];
    for k=1:length(x),
        temp = 0;
        for v=1:length(data),
            temp = temp + exp((-1/2)*(((x(k)-data(v))'*(x(k)-data(v)))/std_dev^2));
        end
        window =[window temp];
    end	
    dist = (1/(N*std_dev*sqrt(2*pi)))*window;
end
